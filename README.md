# ansible_problem_poc
「3社共同企画 Ansible 夏祭り」 - https://connpass.com/event/61994/

# 前提
以下であることを前提としています。

- rootユーザで作業可能
	- Ansibleバージョンを都度切り替えるのため
- `inventory/hosts` のホストへノンパスSSH可能な環境

# 準備

- Ansibleリポジトリのクローン
	- Ansibleバージョンを切り替えるためリポジトリをクローンします。/opt配下とします。
	- `cd /opt`
	- `git clone https://github.com/ansible/ansible.git`
- PoCコードのクローン
	- [Issue #27024](https://github.com/ansible/ansible/issues/27024)で報告されているPoCコードを本リポジトリのrolesディレクトリ配下にクローンします。
	- `cd roles`
	- `git clone https://github.com/zerkms/ansible-include-memory-bug.git`
- テスト実行
	- 以下のコマンドが実行できるか試してみて下さい。動き始めていればOKです。
	- `source change_ansible_ver.sh v2.3.2.0-1 ; ansible-playbook -i inventory/hosts nested_includes.yml`

# 実行

以下のコマンドを実行して下さい。スペックにもよりますが最低1時間くらいはかかると思います。

```
# for VERSION in $(cat test_versions.lst) ; do source change_ansible_ver.sh ${VERSION} ; echo "##### Testing Ansible ${VERSION} #####" ; date ; time ansible-playbook -i inventory/hosts nested_includes.yml | grep -i fail ; sleep 120 ; done
```

## 実行コマンドの解説

- 全体的には `test_versions.lst` のバージョンにAnsibleを切り替えつつForでまわしています。
- `source change_ansible_ver.sh ${VERSION}` でAnsibleバージョンが切り替わります。
- 対して意味もない出力が続くので、大体の結果だけが出るように出力にgrepをかけています。
- リソースの落ち着きのため、バージョンごとに120秒間の待ちがあります。
