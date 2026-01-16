/**
 * null, undefined 체크
 * return true
 */
function checkEmpty (value){

   console.log('value:'+value);
   
   if( null === value || undefined === value ){
    return true;
   }
   
   //value 문자열이고 그리고 앞뒤 공백이 있으면 제거
   if(typeof value === 'string' && value.trim() ===""){
    return true;
   }

   return false;
}


