<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<my:admin tab="merchandise">
	<jsp:attribute name="nav">
		<my:merchandise-nav tab="shelve"></my:merchandise-nav>
	</jsp:attribute>
	<jsp:attribute name="script">
		<script>
		$(function(){
			loadScript();
			//input事件监听
			if(/msie/i.test(navigator.userAgent)) {//ie浏览器
				document.getElementById('address').onpropertychange=handle;
			}else{//非ie浏览器，比如Firefox 
				//firefox下检测状态改变只能用oninput,且需要用addEventListener来注册事件。 
				document.getElementById('address').addEventListener("input",handle,false); 
			}
			//给图片添加事件
			$(document).on("change","input[name='mainpicFile']",function(){
				if(validateImage(this)){
	            	showImage($("#mainImage").get(0),this);
	            }
			});
			$(document).on("change","input[name='mediaFiles']",function(){
				if(validateImage(this)){
					addImage(this);
	            }
			});
		});
		//地址输入框的内容发生改变时发生的事件
		function handle(){
			var input=document.getElementById('address').value;
			//根据输入的内容进行搜索，搜索的结果有标注和批注信息
			var local = new BMap.LocalSearch(map, {renderOptions:{map: map}});
			local.search(input);
		}

		function addImage(input){
			 $div=$("<div class='col-sm-4'></div>");
			 $input=$(input);
			 $input.css("display","none");
			 $img=$("<img height='200' name='mediaImage'></img>");
			 $a=$("<a class='btn btn-link'>删除</a> ");
			 $a.click(function(){
				 $(this).parent().remove();
			 });
			 $div.append($input);
			 $div.append($img);
			 $div.append($a);
			 showImage($img.get(0),input);
			 $("#showImage").append($div);
			 $("#upload_media").append('<input name="mediaFiles" type="file">');
		}

		function deleteMedia(id,mediaid,obj){
			var statu = confirm("确认删除?");
	        if(statu){
	        	$.ajax({
					url:"<c:url value='/admin/merchandise/delMedia'/>",
					data:{id:id,mediaid:mediaid},
					type:"get",
					dataType:"json",
					success:function(data){
						if(data.errcode=="0"){
							window.location.reload(); 
						}
					}
				});	
	        }
			
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
			if($("#shopId").val()=="0"){
				alert('请选择商家!');
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
	        if($("#address").val()==""){
				alert('地址不能为空!');
		        return false;
			}
			if($("#point").html().trim()==""||$("#longitude").val()==""||$("#latitude").val()==""){
				alert('请选择位置');
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
               <label for="shopId" class="col-sm-2 control-label">商家:</label>
               <div class="col-sm-10">
                   <select id="shopId" name="shopId" class="form-control">
               			<option value="0">请选择...</option>
               			<c:forEach items="${shops }" var="shop">
               			<option value="${shop.id }" <c:if test="${shop.id eq t.shopDto.id}">selected</c:if>>${shop.name }</option>
               			</c:forEach>
               		</select>
               </div>
           </div>
           <div class="form-group">
               <label for="name" class="col-sm-2 control-label">商品名称:</label>
               <div class="col-sm-10">
                   <input class="form-control" name="name" value="${t.name }">*
               </div>
           </div>
           <div class="form-group">
               <label for="integralCount" class="col-sm-2 control-label">所需积分:</label>
               <div class="col-sm-10">
                   <input class="form-control" name="integralCount" value="${t.integralCount }">*
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
                   <a id="upload_mainpic" href="javascript:;" class="file">上传<input name='mainpicFile' type="file" ></a><br>
                   <img id="mainImage" src="${t.mainPicDto.url }" height='200'>
               </div>
           </div>
           <div class="form-group">
               <label for="mediaFile" class="col-sm-2 control-label">图片:</label>
               <div class="col-sm-10">
               	   <a id="upload_media" href="javascript:;" class="file">上传<input name='mediaFiles' type="file"  ></a> 
               	   <div id="showImage">
               	   		<c:forEach items="${t.mediaDtos}" var="media">
               	   		<div class="col-sm-4">
               	   			<img name="mediaImage" src="${media.url }" height='200'>
               	   			<a class="btn btn-link" onclick="deleteMedia('${t.id}','${media.id}',this)">删除</a> 
               	   		</div>
               	   		</c:forEach>	
               		</div>
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
               <label for="address" class="col-sm-2 control-label">地址:</label>
               <div class="col-sm-10">
                   <input id="address" class="form-control" name="address" placeholder="请输入商品的地址" 
                   value="<c:if test="${t.type eq '0' }">${t.address }</c:if>">
               </div>
           </div>
           <div class="form-group">
               <label for="point" class="col-sm-2 control-label">位置:</label>
               <div class="col-sm-10">
               	   <input id="longitude" type="hidden" class="form-control" name="longitude" value="${t.longitude}">
                   <input id="latitude" type="hidden" class="form-control" name="latitude" value="${t.latitude}">
                   <p id="point" class="form-control">${t.longitude},${t.latitude}</p><span>点击地图选择具体位置</span>
                   <div id="map" style="width:100%;height:600px"></div>
               </div>
           </div>
           <div class="form-group">
               <label for="remark" class="col-sm-2 control-label">详情介绍:</label>
               <div class="col-sm-10">
                   <textarea rows="10" cols="170" name="remark">${t.remark }</textarea>
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