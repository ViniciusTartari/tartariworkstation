#!/bin/bash

## goInstallDeb10 - Install and config Golang (1.14.4) on Debian 10

echo -e "\033[01;34mGolang (1.14.4) install and configuration - Debian 10 \033[0m"
# -------
echo -e "\033[01;34mDownload Go Binary - 1.14.4\033[0m"
wget https://dl.google.com/go/go1.14.4.linux-amd64.tar.gz

echo -e "\033[01;34mExtraindo e copiando os arquivos para /usr/local\033[0m"
sudo tar -C /usr/local -xzf go1.14.4.linux-amd64.tar.gz   

echo -e "\033[01;34mAdicionando variavel de ambiente\033[0m"
export PATH=$PATH:/usr/local/go/bin

echo -e "\033[01;34mAplicando alteracoes no shell\033[0m"
source $HOME/.profile

echo -e "\033[01;34mTestando instalacao\033[0m"
echo -e "\033[01;34mCriando arquivo de teste\033[0m"
echo 'package main

import "fmt"

func main() {
	fmt.Printf("hello, world\n")
}' > hello.go

echo -e "\033[01;34mBuildando codigo\033[0m"
go build hello.go

echo -e "\033[01;34mExecutando codigo\033[0m"
./hello

echo -e "\033[01;34mSe retornou a frase "Hello, world!" tudo ocorreu como esperado!\033[0m"

echo -e "\033[01;34mRemovendo arquivos gerados no teste\033[0m"
rm hello.go hello

echo -e "\033[01;34mVlw Flw!\033[0m"
