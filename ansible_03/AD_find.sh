#!/bin/bash

krb_path="$1"

krb1="default_etypes = aes128-cts-hmac-sha1-96, aes256-cts-hmac-sha1-96"
krb2="default_as_etypes = aes128-cts-hmac-sha1-96, aes256-cts-hmac-sha1-96"
krb3="default_tgs_etypes = aes128-cts-hmac-sha1-96, aes256-cts-hmac-sha1-96"

sssd_cfg_path="$2"
sssd1="cache_credentials = False"

conf_d_path="$3"

if [[ -e "$krb_path" ]]; then

    if [[ $(grep -x "$krb1" "$krb_path") != "" && $(grep -x "$krb2" "$krb_path") != "" && $(grep -x "$krb3" "$krb_path") != "" ]]; then
        echo "Kerberos encrypton algorithms. Status - Ok."
    else
        echo "Kerberos encrypton algorithms. Status - Error. Solve the problem with config krb5.conf"
    fi

else
        echo "krb5.config not exist"
fi

if [[ -e "$sssd_cfg_path" ]]; then

    if [[ $(grep -xi "$sssd1" "$sssd_cfg_path") != "" ]]; then
        echo "Cache credentials not save. Status - Ok."
    else
        echo "Status - Error. Cache error. Solve the problem with config sssd.conf"
    fi

    if [[ $(grep "fallback_homedir" "$sssd_cfg_path" | awk -F'=' '{print $2}' | grep -v "@%d") != "" ]]; then
        echo "$sssd_cfg_path" $(grep "fallback_homedir" "$sssd_cfg_path" | awk -F'=' '{print $1 $2}' | grep -v "@%d") "Status - Error."
    elif [[ $(grep "fallback_homedir" "$sssd_cfg_path") == ""  ]]; then
        echo "fallback_homedir in $sssd_cfg_path not exist"
    else
        echo "fallback_homedir $sssd_cfg_path Status - Ok."
    fi


else
    echo "sssd.conf not exist"
fi

if [[ -e "$conf_d_path" ]]; then

if [[ -z "$(ls -A $conf_d_path)" ]]; then

    if [[ $(grep -r "fallback_homedir" "$conf_d_path" | awk -F'=' '{print $2}' | grep -v "@%d") != "" ]]; then
        echo $(grep -r "fallback_homedir" "$conf_d_path" | awk -F'=' '{print $1 $2}' | grep -v "@%d") "Status - Error."
    elif [[ $(grep -r "fallback_homedir" "$conf_d_path") == "" ]]; then
        echo "fallback_homedir in not exist, cause $conf_d_path is empty"
    else
        echo "fallback_homedir sssd.conf Status - Ok."
    fi


else

    echo "files conf.d not exist"

fi

else
    echo "conf.d not exist"
fi

