# DBArtigosMusica
### Backup no Linux
```
mkdir ~/backupSQL
chmod 777 ~/backupSQL/
cd ~/backupSQL/
sudo -u postgres pg_dump -f bkp_DBArtigosMusica.sql DBArtigosMusica
```