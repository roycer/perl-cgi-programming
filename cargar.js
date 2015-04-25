function getHttpObject(){
  var XMLHttp;
  if (window.XMLHttpRequest) {
    XMLHttp = new XMLHttpRequest();
  } else if (window.ActiveXObject) {
    XMLHttp = new ActiveXObject("Microsoft.XMLHTTP");
  }
  return XMLHttp;
}

var http = getHttpObject();

function Load(){    
  var nombre = document.getElementById('nombre').value;
  var codigo = document.getElementById('codigo').value;
  var estado = document.getElementById('estado').value;
  var mostrar = document.getElementById('datos');
  if(http){
    http.onreadystatechange = function(){
      if(http.readyState==4 && http.status==200){
        mostrar.innerHTML=http.responseText;
      }
    }
    http.open("GET","cgi-bin/conection.pl?nombre="+nombre+"&codigo="+codigo+"&estado="+estado,true);
    http.send();
  }
}


function LoadDel(){
  var ver = document.getElementById('datos');
  var codigo = document.getElementById('codigo').value;
  if(http){
    http.onreadystatechange = function(){
      if(http.readyState==4 && http.status==200){
        ver.innerHTML=http.responseText;
      }
    }
    http.open("GET","cgi-bin/eliminar.pl?codigo="+codigo,true);
    http.send();
  }
}
