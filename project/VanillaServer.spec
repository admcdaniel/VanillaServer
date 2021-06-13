%define installdir /opt/minecraft
%define backupdir /var/opt/minecraft/backups

Name: VanillaServer
Version: 1.0.0
Release: 1
Summary: Vanilla Minecraft Server
Vendor: amcdaniel

Requires: crontabs, java-1.8.0-openjdk-headless, screen

%description
Simple vanilla minecraft server install. Systemd service for running server,
with scripts for simple world backups.

%install
topdir=%(pwd)/..
mkdir -p %{buildroot}%{installdir}
mkdir -p %{buildroot}%{installdir}/server
mkdir -p %{buildroot}%{installdir}/scripts
mkdir -p %{buildroot}%{backupdir}

cp -fav $topdir/scripts/* %{buildroot}%{installdir}/scripts
cp -fav $topdir/server/*  %{buildroot}%{installdir}/server
cp -fav $topdir/system/VanillaServer.server %{buildroot}%{_unitdir}


%files
%defattr(0775, root, users, 0775)
%{installdir}
%{backupdir}

%post
systemctl enable VanillaServer.service

%preun
%systemd_preun VanillaServer.service

%postun
%systemd_postun_with_restart VanillaServer.service

%changelog