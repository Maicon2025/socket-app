#!/data/data/com.termux/files/usr/bin/bash

echo "Atualizando pacotes..."
pkg update -y
pkg upgrade -y

echo "Instalando dependências..."
pkg install -y wget unzip openjdk-17

echo "Configurando JAVA_HOME..."
export JAVA_HOME=$PREFIX/lib/jvm/openjdk-17
export PATH=$JAVA_HOME/bin:$PATH

echo "Criando estrutura do Android SDK..."
mkdir -p $HOME/Android/Sdk/cmdline-tools
cd $HOME

echo "Baixando Command Line Tools..."
wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip

echo "Extraindo..."
unzip -o commandlinetools-linux-*_latest.zip -d cmdline-tools-temp

echo "Movendo para pasta correta..."
mv cmdline-tools-temp/cmdline-tools $HOME/Android/Sdk/cmdline-tools/latest

rm -rf cmdline-tools-temp
rm commandlinetools-linux-*_latest.zip

echo "Configurando variáveis do Android..."
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

echo 'export JAVA_HOME=$PREFIX/lib/jvm/openjdk-17' >> ~/.bashrc
echo 'export ANDROID_HOME=$HOME/Android/Sdk' >> ~/.bashrc
echo 'export ANDROID_SDK_ROOT=$HOME/Android/Sdk' >> ~/.bashrc
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc
echo 'export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin' >> ~/.bashrc
echo 'export PATH=$PATH:$ANDROID_HOME/platform-tools' >> ~/.bashrc

source ~/.bashrc

echo "Aceitando licenças..."
yes | sdkmanager --licenses

echo "Instalando Android 35..."
sdkmanager "platform-tools"
sdkmanager "platforms;android-35"
sdkmanager "build-tools;35.0.0"

echo "Instalação concluída!"
echo "Reinicie o Termux antes de compilar."
