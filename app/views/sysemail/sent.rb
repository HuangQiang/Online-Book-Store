<font color = "#FF0000"> register successful, please active it before login. </font> </div>

<div class="content">
<h3> <%= @customer.name%>, hello </h3>
please input the address to active your account: <br/>

<a href ='http://localhost:3000/account/pro_activate?name=<%=@customer.name%>>
&active_code=<%=@customer.active_code%>'>
http://localhost:3000/account/pro_activate?name=<%=@customer.name%>
&active_code=<%=@customer.active_code%>

</a>
