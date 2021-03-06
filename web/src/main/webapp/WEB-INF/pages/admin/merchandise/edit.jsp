<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<my:admin tab="merchandise" subtab="shelve">
	<jsp:attribute name="script">
		<script>
		$(function(){
			//给图片添加事件
			$(document).on("change","input[name='mainpicFile']",function(){
				if(validateImage(this)){
	            	showImage(document.getElementById("mainImage"),this.files[0]);
	            }
			});
			$(document).on("change","input[name='mediaFiles']",function(){
				if(validateImage(this)){
					addImage(this);
	            }
			});
			
			//给总店选择改变事件
			$("#shopId").change(function(){
				var html="";
				ajax("<c:url value='/admin/shop/getShop'/>",{shopId:this.value},"get",function(data){
					var bs=data.data.branchs;
					
					for(var i=0;i<bs.length;i++){
						html+='<input id="branchshopIds" name="branchshopIds" value="'+bs[i].id+'" type="checkbox">'+bs[i].name;
					}
					//先清空再追加
					$("#branchshop").html("");
					$("#branchshop").append(html);
				});

			});
		});
		
		function addImage(input){
			for(var i=0;i<input.files.length;i++){
				var $div=$("<div class='col-sm-4'></div>");
				var $img=$("<img height='200' name='mediaImage'></img>");
				var $a=$("<a class='btn btn-link'>删除</a> ");
				$a.click(function(){
					$(this).parent().remove();
				});
				showImage($img.get(0),input.files[i]);
				$div.append($img);
				$div.append($a);
				if(i==input.files.length-1){
					var $input=$(input);
					$input.css("display","none");
					$div.append($input);
				}
				$("#showImage").append($div);
			 }
			 $("#upload_media").append('<input name="mediaFiles" type="file" multiple="multiple">');
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
			//必须要选择一家分店
		    if($("#branchshopIds:checked").length==0){
		    	alert('请至少选择一家分店');
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
			if(typeof($("#mainImage").attr("src"))=="undefined"){
				alert('请上传主图!');
	        	return false;
	        }else if(!validateImageOneToOne($("#mainImage").get(0))){//验证图片宽高比例
				return false;
		    }
	        if($("#showImage").html().trim()==""){
	        	alert('请至少上传一张图片!');
	        	return false;
		    }else{//验证图片宽高比例
			    var flag=true;
				$("img[name='mediaImage']").each(function(){
					if(!validateImageFiveToThree(this)){
						flag=false;
					}	
				});
	        	if(!flag){
		        	return false;
		        }
	        }
	        if($("#price").val()==""){
				alert('价格不能为空!');
	        	return false;
			}
	        if($("#brief").val()==""){
				alert('活动内容不能为空!');
	        	return false;
			}
			if($("#start").val()==""){
				alert('活动开始日期不能为空!');
	        	return false;
			}
			if($("#end").val()==""){
				alert('活动结束日期不能为空!');
	        	return false;
			}
	        var start=$("#start").val();
			var end=$("#end").val();
			if(start.length!=0&&end.length!=0){    
		        var reg = /^\d{4}-\d{2}-\d{2}$/; //全局匹配       
		        var r1 = start.match(reg);
		        var r2 = end.match(reg);    
		        if(r1==null){
		        	alert('对不起，您输入的开始日期格式不正确!例如:格式为2001-01-01');
	            	return false;
			    } 
			    if(r2==null){
			    	alert('对不起，您输入的结束日期格式不正确!例如:格式为2001-01-01');
	            	return false;
				}
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
                   <input type="tel" class="form-control" name="seq" value="${t.seq }">
               </div>
           </div>
           <div class="form-group">
               <label for="classifyId" class="col-sm-2 control-label">商品分类:</label>
               <div class="col-sm-10">
                   <select id="classifyId" name="classifyId" class="form-control">
               			<option value="0">请选择...</option>
               			<c:forEach items="${classifies }" var="classify">
               			<option value="${classify.id }" <c:if test="${classify.id eq t.classifyDto.id}">selected</c:if>>${classify.name }</option>
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
               			<option value="${brand.id }" <c:if test="${brand.id eq t.brandDto.id}">selected</c:if>>${brand.name }</option>
               			</c:forEach>
               		</select>
               </div>
           </div>
           <div class="form-group">
               <label for="shopId" class="col-sm-2 control-label">总店:</label>
               <div class="col-sm-10">
                   <select id="shopId" name="shopId" class="form-control">
               			<option value="0">请选择...</option>
               			<c:forEach items="${shops }" var="shop">
               			<option value="${shop.id }" <c:if test="${shop.id eq t.shopId}">selected</c:if>>${shop.shopName }</option>
               			</c:forEach>
               		</select>
               		
               </div>
           </div>
           <div class="form-group">
               <label for="name" class="col-sm-2 control-label">选择分店:</label>
               <div class="col-sm-10" id="branchshop">
               		<c:forEach items="${branchShops }" var="branchShop">
               		<input id="branchshopIds" name="branchshopIds" value="${branchShop.id }" type="checkbox" 
	               		<c:forEach items="${t.shopDtos }" var="branchShopDto">
	               		<c:if test="${branchShopDto.id eq branchShop.id }">checked</c:if>
	               		</c:forEach>
               		/>${branchShop.name }
               		</c:forEach>
               	</div>
           </div>
           <div class="form-group">
               <label for="name" class="col-sm-2 control-label">商品名称:</label>
               <div class="col-sm-10">
                   <input class="form-control" name="name" value="${t.name }">*
               </div>
           </div>
           <div class="form-group">
               <label for="type" class="col-sm-2 control-label">是否实物商品:</label>
               <div class="col-sm-10">
               	<input type="checkbox" name="type" value="1" <c:if test="${t.type eq '1'}">checked</c:if>/>
               </div>
           </div>
           <div class="form-group">
               <label for="integralCount" class="col-sm-2 control-label">所需积分:</label>
               <div class="col-sm-10">
                   <input class="form-control" name="integralCount" value="${t.integralCount }">*
               </div>
           </div>
           <div class="form-group">
               <label for="price" class="col-sm-2 control-label">价格:</label>
               <div class="col-sm-10">
                   <input id="price" type="tel" class="form-control" name="price" value="${t.price }">
               </div>
           </div>
           <div class="form-group">
               <label for="brief" class="col-sm-2 control-label">活动内容:</label>
               <div class="col-sm-10">
                   <input id="brief" class="form-control" name="brief" value="${t.brief}" placeholder="please input brief">
               </div>
           </div>
           <div class="form-group">
               <label for="start" class="col-sm-2 control-label">开始日期:</label>
               <div class="col-sm-10">
                   <input id="start" class="form-control" name="start" value="${t.start}" placeholder="例如:格式为2001-01-01">
               </div>
           </div>
           <div class="form-group">
               <label for="end" class="col-sm-2 control-label">结束日期:</label>
               <div class="col-sm-10">
                   <input id="end" class="form-control" name="end" value="${t.end}"  placeholder="例如:格式为2001-01-01">
               </div>
           </div>
           
           <div class="form-group">
               <label for="stock" class="col-sm-2 control-label">库存:</label>
               <div class="col-sm-10">
                   <input type="tel" class="form-control" name="stock" value="${t.stock }">*
               </div>
           </div>
           <div class="form-group">
               <label for="original" class="col-sm-2 control-label">渠道专享:</label>
               <div class="col-sm-10">
                   <input class="form-control" name="original" value="${t.original }">
               </div>
           </div>

           <div class="form-group">
               <label for="mainPic" class="col-sm-2 control-label">主图片:</label>
               <div class="col-sm-10">
                   <a id="upload_mainpic" href="javascript:;" class="file">上传<input name='mainpicFile' type="file"  ></a><br>
                   <img id="mainImage" src="${t.mainPicDto.url }" height="200">
               </div>
           </div>
           <div class="form-group">
               <label for="mediaFile" class="col-sm-2 control-label">图片:</label>
               <div class="col-sm-10">
               	   <a id="upload_media" href="javascript:;" class="file">上传<input name='mediaFiles' type="file" multiple="multiple"></a> 
               	   <div id="showImage">
               	   		<c:forEach items="${t.mediaDtos}" var="media">
               	   		<div id="${media.id }" class="col-sm-4">
               	   			<img src="${media.url }" height="200" name='mediaImage'>
               	   			<a class="btn btn-link" 
               	   			 onclick="del('<c:url value='/admin/merchandise/${t.id}/media'/>','${media.id}');">删除</a> 
               	   		</div>
               	   		</c:forEach>	
               		</div>
               </div>
           </div>
           <div class="form-group">
               <label for="remark" class="col-sm-2 control-label">详情介绍:</label>
               <div class="col-sm-10">
                   <textarea name="remark" style="resize:none;height:150px;width:100%;">${t.remark }</textarea>
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