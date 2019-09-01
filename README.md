# Easy install FreePBX on VPS with Cent OS
<h3>Pre-requsites</h3>
<ul>
<li>SELinux is <a href="https://serveradmin.ru/centos-7-nastroyka-servera/#_CentOS_7">disabled</a></li>
<li>CentOS 7</li>
<li><a href="https://serveradmin.ru/nastroyka-servera-telefonii-asterisk-s-nulya/#i-3">Asterisk</a> setup</li>
</ul>
<h3>Lets get started</h3>
Tuning when you first start a clean system<br>
<code>wget https://raw.githubusercontent.com/lexx/asterisk/master/first_run.sh</code><br>
<code>sh first_run.sh</code><br>

First we need to clone/get the script found in github repo<br>
<code>wget https://raw.githubusercontent.com/lexx/asterisk/master/install_clean_asterisk.sh</code><br>
OR<br>
<code>wget https://raw.githubusercontent.com/lexx/asterisk/master/install_freepbx.sh</code><br><br>
Next, run the script<br>
<code>sh install_clean_asterisk.sh</code><br>
OR<br>
<code>sh install_freepbx.sh</code><br>
The Script will run for a bit, afterwards, choose your options for MariaDB - <b>DO NOT USE A ROOT PASSWORD</b>.<br>
The Script will run for a bit more, you then will be able to choose if you would like any more Asterisk modules to be installed.<br><br>
The script will then finish and you can browse to the FreePBX WebGUI using the droplet IP address.

<h3>Troubleshooting</h3>
MODULENAME tampered If you get such errors in FreePBX web interface:
<pre>MODULENAME tampered
MODULENAME/file is wrong
You have 1 tampered files Module: "FreePBX Framework"</pre>
run <code>fwconsole ma upgrade MODULENAME</code> also try <code>fwconsole a ma refreshsignatures</code>

<h3>Credits</h3>
Forked from <a href="https://github.com/raysn0w">raysn0w</a><br>
Original script belongs to <a href="https://github.com/cameronbackus/">Cameron</a>
