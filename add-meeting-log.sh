#!/bin/bash

ID=$1

echo ${ID}

# -ハイフン始まりのIDの場合もある
hackmd-cli export --md "${ID}" tmp.md

# Hugoのサイト生成に必要なデータをDLファイルより取得する

MEETING_PLACE=$(grep '^# \{1,\}\(姫路\|加古川\).*勉強会.*$' tmp.md | grep -o '\(姫路\|加古川\)')

case ${MEETING_PLACE} in
  姫路) MEETING_DIR=histudy ;;
  加古川) MEETING_DIR=kakogawa_infra ;;
esac

MEETING_DATE=$(grep '\* 開催日.*' tmp.md | grep -oP '[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}')

echo "Generate ${MEETING_PLACE} ${MEETING_DATE} meeting log."

YEAR=$(echo $MEETING_DATE | sed -r 's#([0-9]{4})/([0-9]{1,2})/[0-9]{1,2}#\1#')
MONTH=$(echo $MEETING_DATE | sed -r 's#([0-9]{4})/([0-9]{1,2})/[0-9]{1,2}#\2#')
DAY=$(echo $MEETING_DATE | sed -r 's#([0-9]{4})/([0-9]{1,2})/[0-9]{1,2}#\3#')

if test ${#MONTH} -eq 1 ; then
  MONTH="0${MONTH}"
fi

DEST_MD=$(echo "content/${MEETING_DIR}/${YEAR}/${MONTH}.md")

echo $DEST_MD

hugo new ${MEETING_DIR}/${YEAR}/${MONTH}.md

# フロントマター書き換え
sed -i -r "s/(title: 姫路IT系勉強会 )YYYY.MM/\1${YEAR}.${MONTH}/" ${DEST_MD}
sed -i -r "s/(title: 加古川IT系インフラ勉強会 )YYYY.MM/\1${YEAR}.${MONTH}/" ${DEST_MD}
sed -i -r "s#date:.*#date: ${YEAR}-${MONTH}-${DAY}#" ${DEST_MD}

#フロントマターのTitleが表示されるので、h1より後ろのみ
H1=$(grep -n '^# \{1,\}\(姫路\|加古川\).*勉強会.*$' tmp.md | cut -f 1 -d ":")

cat tmp.md | sed 1,${H1}d >> ${DEST_MD}

rm tmp.md

exit 0
