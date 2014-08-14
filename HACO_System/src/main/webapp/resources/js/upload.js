$(function(){

//photoUpFile
$('#loadingIcon').hide();     
$('#progress_thumbnail').hide();

$('#photoUpFile').fileupload({
	url : '/haco/management/photoUpload', 
	dataType: 'json',
    //replaceFileInput: false,
    dropZone:$(''),
    singleFileUploads: 'true',
    limitMultiFileUploads:'1',
            add: function(e, data){
                $('#loadingIcon').fadeIn();
                $('#progress_thumbnail .progress-bar').css('width', '0%');
                var validFlag = true;
                var uploadFile = data.files[0];

                if (!(/png|jpe?g|gif/i).test(uploadFile.name)) {
                    alert('png, jpg, gif 만 가능합니다');
                    validFlag = false;   
                }else if (uploadFile.size > 5*1024*1024) { // 5mb
                    alert('파일 용량은 5메가를 초과할 수 없습니다.');
                    validFlag = false;
                }else{
                    var _URL = window.URL || window.webkitURL; 
    				var img = new Image();
    		        img.onload = function() {
    		        	if (this.width < 118 || this.height < 157){
    		                alert('118 x 157 보다 큰 이미지를 선택해 주세요.');
    		                validFlag = false;
    		        	}
    		        	_URL.revokeObjectURL(img.src);
    		        	
    		        	if (!validFlag) {
    	                    // <input> 초기화 코드
    	                    data.reset();
    	                }else{
    	                	$('#progress_thumbnail').slideDown(100,function(){});
    	                	data.submit();
    	                }
    		        };
    		        img.src = _URL.createObjectURL(uploadFile);
                }
            },
            progressall: function(e,data) {
                var progress = parseInt(data.loaded / data.total * 100, 10);
                $('#progress_thumbnail .progress-bar').css('width', progress + '%');
            },
            done: function (e, data) {
                $('#loadingIcon').fadeOut();            	
            	$('#progress_thumbnail').slideUp(1000,function(){});
            	$('#photo').val(data.result.renameFileName);
            	$('#img-preview img').attr("src","/haco/employeePhoto/"+data.result.renameFileName);
            	console.log("업로드 성공");
            },
            fail: function(){
                $('#loadingIcon').fadeOut();     
            	$('#progress_thumbnail').slideUp(1000,function(){});
                alert("서버와 통신 중 문제가 발생했습니다");
            }
        });
		//- dataType : 서버에서 응답받을 데이터의 타입. (xml, json, script, or html)
		//- replaceFileInput : 기본값은 true, 파일이 첨부되면 이벤트 핸들링 시점에서 파일입력폼을 클론으로 대체한다. 
 		//이 값이 false면 fileUpload 이벤트 후에도 파일입력폼의 첨부파일이 사라지지 않는다.1
		//- life cycle은 add -> progress -> done or fail
		
		

        
        //글자수 제한
        var textLengthCheck = function(maxLength,count,input){
	        var $count = $(count);
	        var $input = $(input);
	        
	        $input.on('focus blur keydown keyup paste', function(){
	        	var textLength = $input.val().length;
	            var remain = maxLength - textLength;
	            if (remain < 0) {    
	            	var str = $input.val();
	            	
	            	alert('최대'+maxLength+"자까지 작성할 수 있습니다.");
	            	$input.val(str.substr(0, maxLength));            
	            	count = 0;       
	            }
	        	$count.text(textLength+"/"+maxLength+"자");  
	        });
        };

        textLengthCheck(40,'#pjt_tit','#subject');
        textLengthCheck(800,'#pjt_desc','#content');

        
        
        //전송
        $('.btn_ty5').on('click',function(e){
        	e.preventDefault();     
        	
        	//유효성 체크
			if($('#subject').val() == ""){
				alert("제목을 입력하세요");
				$('#subject').focus();
				return;
			}else if($('#content').val() == ""){
				alert("소개글을 입력하세요");
				$('#content').focus();
				return;
			}else if($('#thumbnail').val() == ""){
				alert("썸네일 이미지를 등록해주세요");
				$(window).scrollTop($('#img-preview').offset().top-70);
				return;
			}else if($('.add_img').size() == 0){
				alert("한개 이상의 이미지를 등록해주세요");
				return;
			}else{
				var flag = true;
				$('.add_img').each(function(){
					var index = $('.add_img').index(this)+1;
					if($(this).find("input[name='img_tag']").val()==""){
						alert(index+"번째 이미지의 태그를 입력해주세요");
						$(this).find("input[name='img_tag']").focus();
						flag = false;
					}
				});
				if(!flag){
					return;
				}
			}			
			
        	
        	var refcount = 0; 	//전송 객체 넘버링
    		var completecount = 0; //완료 카운트
    		
        	var sendData = {
        			subject: $("#subject").val(),
                    content: $("#content").val(),
                    secret: $('#secret').is(':checked'),
                    thumbnail: $("#thumbnail").val()
            };
    		$.post(//본문 등록
    			"../boardorder/articlewrite", 	//url
				sendData ,       				//data(send)
			    function(writeidx){
    				$('#idx').val(writeidx);
					$('.add_img').each(function(){
		        		$.post(//이미지 등록
		        			"../boardorder/imagewrite",
		        			{
		        				idx : writeidx,
		        				ref : refcount,
		        				subject : $(this).find("input[name='img_subject']").val(),
		        				content : $(this).find("textarea[name='img_dsc']").val(),
		        				ori_name : $(this).find("input[name='ori_file_name']").val(),
		        				file_name : $(this).find("input[name='file_name']").val(),
		        				file_size : $(this).find("input[name='file_size']").val(),
		        				tag : $(this).find("input[name='img_tag']").val()
		        			},
		        			function(returndata){
		        				if(returndata==0){
		        					alert("이미지 등록에 실패했습니다\n다시 시도해 주세요");
		        				}else{
		        					if(++completecount==$('.add_img').size()){
		        						$('#processform').trigger('submit');
		        					}
		        				}	        				
		        			}
		        		).done(function() {
		        		})
		        		.fail(function() {
		                    alert("서버와 통신 중 문제가 발생했습니다");
		        		});
		        		refcount++;
		        	});
					//alert('전송후');
				}
   		);
        });      
});