# additional steps

## virtual

* chsh -s `which zsh`
* install guest additions
  - mkdir /media/optical
  - mount /dev/sr0 /media/optical/
  - /media/optical/VBoxLinuxAdditions.run
* add user to vbox group
  - sudo usermod -a -G vboxsf mephisto
