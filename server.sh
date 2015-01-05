mkdir .ssh
chmod 700 .ssh
cd .ssh
touch authorized_keys
chmod 600 authorized_keys
read -p "Auth Key : " authkey
echo $authkey >> authorized_keys
echo ==============
echo Authenticated
echo ==============