#!/bin/bash
dashes='================================================================================='
# Git URL
git_url="https://github.com/donaldzou/WGDashboard.git"
# Check Python version
version_pass=$(python3 -c 'import sys; print("1") if (sys.version_info.major == 3 and sys.version_info.minor >= 7) else print("0");')
# Get the newest version
new_ver=$(python3 -c "import json; import urllib.request; data = urllib.request.urlopen('https://api.github.com/repos/donaldzou/WGDashboard/releases/latest').read(); output = json.loads(data);print(output['tag_name'])")

exit_install(){
  printf "| Installation stopped                                                          |\n"
  printf "%s\n" "$dashes"
  exit 1
}



printf "=================================================================================\n"
printf "+          <WGDashboard> by Donald Zou - https://github.com/donaldzou           +\n"
printf "=================================================================================\n"
printf "| Installing WGDashboard...                                                     |\n"
printf "| Checking if Python3 and Pip are installed...                                  |\n"
if ! python3 --version >  /dev/null 2>&1; then
  printf "=================================================================================\n"
  printf "| Python 3 is not installed, required Python 3.7 or above                       |\n"
  printf "=================================================================================\n"
  exit_install
fi
if ! python3 -m pip -V >  /dev/null 2>&1; then
  printf "=================================================================================\n"
  printf "| Pip is not installed                                                          |\n"
  printf "=================================================================================\n"
  exit_install
fi
printf "| Checking Python version...                                                    |\n"
if [ $version_pass == "0" ]; then
  printf "=================================================================================\n"
  printf "| WGDashboard required Python 3.7 or above                                      |\n"
  printf "=================================================================================\n"
  exit_install
fi
printf "| Downloading WGDashboard from GitHub...                                        |\n"
git clone -b $new_ver $git_url wgdashboard >  /dev/null 2>&1
printf "| Installing Python dependencies...                                             |\n"
python3 -m pip install -r wgdashboard/src/requirements.txt >  /dev/null 2>&1
rm wgdashboard/src/db/hi.txt >  /dev/null 2>&1
chmod u+x wgdashboard/src/wgd.sh
chmod -R 755 /etc/wireguard
rm wgdashboard/src/install.sh
printf "| WGDashboard installed successfully!                                           |\n"
printf "| You can now start WGDashboard by:                                             |\n"
printf "|         > cd wgdashboard/src                                                  |\n"
printf "|         > ./wgd.sh start                                                      |\n"
printf "=================================================================================\n"