#!/bin/bash  

COPY_DIR_NAME=""
PARAMETER=""

#参数获取资源路径
if [ x$1 != x ]
then
for args in $@
do
if [ $1 == $args ]; then
    COPY_DIR_NAME=$args
elif [ $2 == $args ]; then
    PARAMETER="-name *."$args
else
    PARAMETER=$PARAMETER" -or -name *."$args
fi
done
fi

#判断参数是否满足
if [ x"$COPY_DIR_NAME" == x ]; then
    echo "输入文件的存放目录名称"
    exit
fi
if [ x"$PARAMETER" == x ]; then
    echo "输入需要查找文件的后缀"
    exit
fi

#指定到脚本文件目录
cd "$(dirname "$0")"

if [ -d "${COPY_DIR_NAME}" ]
then
rm -rf "${COPY_DIR_NAME}"
fi
mkdir -p "${COPY_DIR_NAME}"

#发现并拷贝xib、png文件
find . -type f $PARAMETER | xargs -I {} cp -p {} $COPY_DIR_NAME
