#!/bin/bash

krb_path="$1"
alg="aes128-cts-hmac-sha1-96, aes256-cts-hmac-sha1-96"

sssd_cfg_path="$2"
sssd1="cache_credentials"

conf_d_path="$3"

if [[ -e "$krb_path" ]]; then

	krb1=$(grep -w "default_etypes" "$krb_path" | awk -F'=' '{print $2}' | xargs)
	krb2=$(grep -w "default_as_etypes" "$krb_path" | awk -F'=' '{print  $2}' | xargs)
	krb3=$(grep -w "default_tgs_etypes" "$krb_path" | awk -F'=' '{print $2}' | xargs)


    if [[ "$krb1" == "$alg" && "$krb2" == "$alg" && "$krb3" == "$alg" ]]; then
        echo "Kerberos encrypton algorithms. Status - Ok."
    else
        echo "Kerberos encrypton algorithms. Status - Error. Solve the problem with config krb5.conf"
    fi

else
        echo "krb5.config not exist"
fi

if [[ -e "$sssd_cfg_path" ]]; then

    if [[ $(grep -w "$sssd1" "$sssd_cfg_path" | awk -F'=' '{print $2}' | xargs ) == "false" ]]; then
        echo "Cache credentials not save. Status - Ok."
    else
        echo "Error. Cache error. Solve the problem with config sssd.conf"
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
        echo "fallback_homedir is not exist in '$conf_d_path'"
    else
        echo "fallback_homedir sssd.conf Status - Ok."
    fi


else

    echo "files conf.d not exist"

fi

else
    echo "conf.d not exist"
fi

