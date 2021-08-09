%define installdir /opt/minecraft
%define backupdir /var/opt/minecraft/backups

Name: VanillaServer
Version: 1.0.0
Release: 1
License: GPL
Summary: Vanilla Minecraft Server
Vendor: amcdaniel

Requires: crontabs, java-latest-openjdk-headless, screen

%description
Simple vanilla minecraft server install. Systemd service for running server,
with scripts for simple world backups.

%build
topdir=%(pwd)/..
ind $topdir/scripts $topdir/system $topdir/resources -type f -print0 | xargs -0 dos2unix

%install
topdir=%(pwd)/..
mkdir -p %{buildroot}%{installdir}
mkdir -p %{buildroot}%{installdir}/server
mkdir -p %{buildroot}%{installdir}/scripts
mkdir -p %{buildroot}%{backupdir}
mkdir -p %{buildroot}/etc/sudoers.d
mkdir -p %{buildroot}%{_unitdir}

cp -fav $topdir/scripts/* %{buildroot}%{installdir}/scripts
cp -fav $topdir/resources/config/*  %{buildroot}%{installdir}/server
cp -fav $topdir/system/systemd/VanillaMCServer.service %{buildroot}%{_unitdir}
cp -fav $topdir/system/sudoers.d/mcServer %{buildroot}/etc/sudoers.d/


%files
%defattr(0775, root, users, 0775)
%{installdir}
%{backupdir}
%{_unitdir}/VanillaMCServer.service
/etc/sudoers.d/mcServer


%post
systemctl enable VanillaMCServer.service
%{installdir}/scripts/initalizeServer.sh

%preun
%systemd_preun VanillaMCServer.service

%postun
%systemd_postun_with_restart VanillaMCServer.service
userdel mc
rm -fr /opt/minecraft

%changelog