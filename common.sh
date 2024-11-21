log_file=/tmp/expense.log

Head(){
  echo -e "\e[35m$1\e[0m"
}
App_Prereq()
{
  DIR=$1
  Head  "remove existing App content"
  rm -rf $1  &>>log_file
  echo $?

  Head  "create application directory"
  mkdir $1  &>>log_file
  echo $?

  Head  "download Application content"
  curl -o /tmp/${component}.zip https://expense-artifacts.s3.amazonaws.com/${component}.zip &>>log_file
  echo $?

   cd /$1

  Head  "extracting the application content"
  unzip /tmp/${component}.zip &>>log_file
  echo $?
}
stat()
{
if [ $? -eq 0 ]; then
  echo success
else
  echo Failure
  exit 1
fi
}