sudo apt -y install file strings checksec binwalk patchelf

# gdb-peda
sudo apt -y install gdb gdbserver
git clone https://github.com/longld/peda.git ~/peda
echo "source ~/peda/peda.py" >> ~/.gdbinit

gdb --version