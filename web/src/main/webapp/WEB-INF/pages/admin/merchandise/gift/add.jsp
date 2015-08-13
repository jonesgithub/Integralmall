<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<my:admin tab="integral">
	<jsp:attribute name="nav">
		<my:integral-nav tab="merchandise"></my:integral-nav>
	</jsp:attribute>
	<jsp:attribute name="script">
	<script>
	function addMainpic(source) {  
        var file = source.files[0];  
        if(window.FileReader) {  
            var fr = new FileReader();  
            fr.onloadend = function(e) {  
                document.getElementById("mainImage").src = e.target.result;  
				
            };  
            fr.readAsDataURL(file);  
        }  
    } 
	function addImage(input){
		 var file = input.files[0];
		 $div=$("<div class='col-sm-3'></div>");
		 $input=$(input);
		 $input.css("display","none");
		 $img=$("<img width='200' height='200'></img>");
		 $a=$("<a class='btn btn-link'>删除</a> ");
		 $a.click(function(){
			 $(this).parent().remove();
		 });
		 $div.append($input);
		 $div.append($img);
		 $div.append($a);
		 if(window.FileReader) {  
            var fr = new FileReader();
            fr.readAsDataURL(file); 
            fr.onloadend = function(e) {  
            	$img.attr("src", e.target.result);  
            }; 
              
        }
		 $("#showImage").append($div);
		 $("#upload_media").append('<input name="mediaFiles" type="file" onchange="addImage(this)" >');
	}
	
	function validate(){
		if($("#classifyId").val()=="0"){
			alert('请选择商品分类!');
        	return false;
		}
		if($("#brandId").val()=="0"){
			alert('请选择商品品牌!');
        	return false;
		}
		if($("#name").val()==""){
			alert('商品名称不能为空!');
        	return false;
		}
		if($("#integralCount").val()==""){
			alert('所需积分不能为空!');
        	return false;
		}
		if($("#stock").val()==""){
			alert('商品库存不能为空!');
        	return false;
		}
		if($("#mainImage").attr("src")==null){
			alert('请上传主图!');
        	return false;
        }
		if($("#showImage").html().trim()==""){
	        alert('请至少上传一张图片!');
	        return false;
		}
		if($("#price").val()==""){
			alert('价格不能为空!');
        	return false;
		}
        return true;
	}

	
	
	</script>
	</jsp:attribute>
	<jsp:body>
		<form action="./" role="form" class="form-horizontal" method="post" enctype="multipart/form-data" onsubmit="return validate()">
           <div class="form-group">
               <label for="seq" class="col-sm-2 control-label">编号:</label>
               <div class="col-sm-10">
                   <input type="tel" class="form-control" name="seq" placeholder="please input seq">
               </div>
           </div>
           <div class="form-group">
               <label for="classifyId" class="col-sm-2 control-label">商品分类:</label>
               <div class="col-sm-10">
               		<select id="classifyId" name="classifyId" class="form-control">
               			<option value="0">请选择...</option>
               			<c:forEach items="${classifies }" var="classify">
               			<option value="${classify.id }">${classify.name }</option>
               			</c:forEach>
               		</select>
               </div>
           </div>
           <div class="form-group">
               <label for="brandId" class="col-sm-2 control-label">商品品牌:</label>
               <div class="col-sm-10">
                   <select id="brandId" name="brandId" class="form-control">
                   		<option value="0">请选择...</option>
               			<c:forEach items="${brands }" var="brand">
               			<option value="${brand.id }">${brand.name }</option>
               			</c:forEach>
               		</select>
               </div>
           </div>
           <div class="form-group">
               <label for="name" class="col-sm-2 control-label">商品名称:</label>
               <div class="col-sm-10">
                   <input id="name" class="form-control" name="name" placeholder="please input name">*
               </div>
           </div>
           <div class="form-group">
               <label for="integralCount" class="col-sm-2 control-label">所需积分:</label>
               <div class="col-sm-10">
                   <input id="integralCount" class="form-control" name="integralCount" placeholder="please input integralCount">*
               </div>
           </div>
           <div class="form-group">
               <label for="price" class="col-sm-2 control-label">价格:</label>
               <div class="col-sm-10">
                   <input id="price" type="tel" class="form-control" name="price" placeholder="please input price">
               </div>
           </div>
           <div class="form-group">
               <label for="stock" class="col-sm-2 control-label">库存:</label>
               <div class="col-sm-10">
                   <input id="stock" type="tel" class="form-control" name="stock" placeholder="please input stock">*
               </div>
           </div>
           <div class="form-group">
               <label for="original" class="col-sm-2 control-label">渠道专享:</label>
               <div class="col-sm-10">
                   <input class="form-control" name="original" placeholder="please input original">
               </div>
           </div>

           <div class="form-group">
               <label for="mainPic" class="col-sm-2 control-label">主图片:</label>
               <div class="col-sm-10">
                   <a id="upload_mainpic" href="javascript:;" class="file">上传<input name='mainpicFile' type="file" onchange="addMainpic(this)" ></a><br>
                   <img id="mainImage" width="200" height="200">
               </div>
           </div>
           <div class="form-group">
               <label for="media" class="col-sm-2 control-label">图片:</label>
               <div class="col-sm-10">
                   <a id="upload_media" href="javascript:;" class="file">上传<input name='mediaFiles' type="file" onchange="addImage(this)" ></a>
                   <div id="showImage">
	               	   <%-- <div class='col-sm-3'>
	               	   <input type="file"/>
		               	   <img />
		               	   <a class="btn btn-link">删除</a> 
	               		</div> --%>
               		</div>
               </div>
           </div>
           <div class="form-group">
               <label for="remark" class="col-sm-2 control-label">详情介绍:</label>
               <div class="col-sm-10">
               <textarea rows="10" cols="170" name="remark"></textarea>
               </div>
           </div>
		   <div class="form-group">
			   <div class="col-sm-offset-2 col-sm-10">
			      <button type="submit" class="btn btn-default">保存</button>
			   </div>
		   </div>
       </form>
	</jsp:body>
</my:admin>