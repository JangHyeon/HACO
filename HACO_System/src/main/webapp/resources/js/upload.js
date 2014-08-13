$(function(){

//photoUpFile
$('#photoUpFile').fileupload({
	url : '/haco/management/photoUpload', 
	dataType: 'json',
    //replaceFileInput: false,
    dropZone:$(''),
    singleFileUploads:false,
    limitMultiFileUploads:1,
            
            add: function(e, data){
                $('#progress_thumbnail .progress-bar').css('width', '0%');
                var validFlag = true;
                var uploadFile = data.files[0];

                if (!(/png|jpe?g|gif/i).test(uploadFile.name)) {
                    validFlag = false;   
                }else if (uploadFile.size > 5*1024*1024) { // 5mb
                    alert('�뚯씪 �⑸웾��5硫붽�瑜�珥덇낵�����놁뒿�덈떎.');
                    validFlag = false;
                }else{
                    var _URL = window.URL || window.webkitURL; 
    				var img = new Image();
    		        img.onload = function() {
    		        	if (this.width < 118 || this.height < 157){
    		                alert('118 x 157 蹂대떎 ���대�吏�� �좏깮��二쇱꽭��');
    		                validFlag = false;
    		        	}
    		        	_URL.revokeObjectURL(img.src);
    		        	
    		        	if (!validFlag) {
    	                    // <input> 珥덇린��肄붾뱶
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
            	$('#progress_thumbnail').slideUp(1000,function(){});
            	$('#photo').val(data.result.renameFileName);
            	$('#img-preview img').attr("src","/haco/employeePhoto/"+data.result.renameFileName);
            	console.log("�낅줈���깃났");
            },
            fail: function(){
            	$('#progress_thumbnail').slideUp(1000,function(){});
                alert("�쒕쾭���듭떊 以�臾몄젣媛�諛쒖깮�덉뒿�덈떎");
            }
        });
		//- dataType : �쒕쾭�먯꽌 �묐떟諛쏆쓣 �곗씠�곗쓽 ��엯. (xml, json, script, or html)
		//- replaceFileInput : 湲곕낯媛믪� true, �뚯씪��泥⑤��섎㈃ �대깽���몃뱾留��쒖젏�먯꽌 �뚯씪�낅젰�쇱쓣 �대줎�쇰줈 ��껜�쒕떎. 
 		//��媛믪씠 false硫�fileUpload �대깽���꾩뿉���뚯씪�낅젰�쇱쓽 泥⑤��뚯씪���щ씪吏�� �딅뒗��1
		//- life cycle��add -> progress -> done or fail
		
		
      //append_upload
        $('#appendform').fileupload({
            url : '../boardorder/imageappend',
            dataType: 'html',
            //replaceFileInput: false,
            dropZone:$(''),
            
            add: function(e, data){
            	$('#tempcount').val($('#sortable').children().size());
            	$('#progress_append .progress-bar').css('width', '0%');
                
                var validFlag = true;
                var uploadFile = data.files[0];
                
                if (!(/png|jpe?g|gif/i).test(uploadFile.name)) {
                    alert('png, jpg, gif 留�媛�뒫�⑸땲��');
                    validFlag = false;   
                }else if (uploadFile.size > 5*1024*1024) { // 5mb
                    alert('�뚯씪 �⑸웾��5硫붽�瑜�珥덇낵�����놁뒿�덈떎.');
                    validFlag = false;
                }
                
                if (!validFlag) {
	        		// <input> 珥덇린��肄붾뱶
	        		data.reset();
	        	}else{
	        		$('#progress_append').slideDown(100,function(){});
	        		data.submit();
	        	}                
            },
            progressall: function(e,data) {
                var progress = parseInt(data.loaded / data.total * 100, 10);
                $('#progress_append .progress-bar').css('width', progress + '%');
            },
            done: function (e, data) {
            	$('#progress_append').slideUp(1000,function(){});
            	setTimeout(function(){
            		$('#sortable').append(data.result);
            		$('#sortable').children('.add_img').eq($('#tempcount').val()).css('display','none');
            		$('#sortable').children('.add_img').eq($('#tempcount').val()).slideDown(500, function(){});
            	},500); 
            	console.log("�낅줈���깃났");
            },
            fail: function(){
            	$('#progress_append').slideUp(1000,function(){});
                alert("�쒕쾭���듭떊 以�臾몄젣媛�諛쒖깮�덉뒿�덈떎");
            }
        });
        
        
        //�뺣젹
        $('#sortable').sortable({
        	axis:'y',						//�대룞異뺢퀬��
        	opactiy: 0.5,					//�щ챸��
        	handle:'.handle',				//�쒕옒洹몄쁺��
        	placeholder:'dropplaceholder',	//鍮덉옄由�蹂댁뿬以꼊ss
        	revert: true,					//遺�뱶�ъ슫 蹂듦�
        	//containment: 'parent',			//�쒕옒洹��곸뿭 �뺥빐二쇨린(遺�え�곸뿭) API李몄“
        	//tolerance: 'pointer', 		//�쒕옒洹��ㅼ감(而ㅼ꽌)
        	//helper : 'clone' 				//helper : clone濡��ㅼ젙���쒕젅洹��대깽�몄떆 �대┃ �대깽�몃뒗 �숈옉�섏� �딅뒗��" +
        									//(紐낇솗���섎���.... �쒕젅洹몄떆 洹��곗쓽 �대깽�몃뒗 臾댁떆�댁＜���먮굦)        	
        });
        
        
        //異붽� �대�吏���젣
        $('#sortable').on('click','.btn_close',function(e){
        	e.preventDefault();
        	var index = $('.btn_close').index(this);
        	console.log(index);
        	$('#sortable').children('.add_img').eq(index).remove();
        });
        
        
        //湲�옄���쒗븳
        var textLengthCheck = function(maxLength,count,input){
	        var $count = $(count);
	        var $input = $(input);
	        
	        $input.on('focus blur keydown keyup paste', function(){
	        	var textLength = $input.val().length;
	            var remain = maxLength - textLength;
	            if (remain < 0) {    
	            	var str = $input.val();
	            	
	            	alert('理쒕�'+maxLength+"�먭퉴吏��묒꽦�����덉뒿�덈떎.");
	            	$input.val(str.substr(0, maxLength));            
	            	count = 0;       
	            }
	        	$count.text(textLength+"/"+maxLength+"/");  
	        });
        };

        textLengthCheck(40,'#pjt_tit','#subject');
        textLengthCheck(800,'#pjt_desc','#content');

        
        
        //�꾩넚
        $('.btn_ty5').on('click',function(e){
        	e.preventDefault();     
        	
        	//�좏슚��泥댄겕
			if($('#subject').val() == ""){
				$('#subject').focus();
				return;
			}else if($('#content').val() == ""){
			
				$('#content').focus();
				return;
			}else if($('#thumbnail').val() == ""){
				$(window).scrollTop($('#img-preview').offset().top-70);
				return;
			}else if($('.add_img').size() == 0){
				return;
			}else{
				var flag = true;
				$('.add_img').each(function(){
					var index = $('.add_img').index(this)+1;
					if($(this).find("input[name='img_tag']").val()==""){
						$(this).find("input[name='img_tag']").focus();
						flag = false;
					}
				});
				if(!flag){
					return;
				}
			}			
			
        	
        	var refcount = 0; 	//�꾩넚 媛앹껜 �섎쾭留�
    		var completecount = 0; //�꾨즺 移댁슫��
    		
        	var sendData = {
        			subject: $("#subject").val(),
                    content: $("#content").val(),
                    secret: $('#secret').is(':checked'),
                    thumbnail: $("#thumbnail").val()
            };
    		$.post(//蹂몃Ц �깅줉
    			"../boardorder/articlewrite", 	//url
				sendData ,       				//data(send)
			    function(writeidx){
    				$('#idx').val(writeidx);
					$('.add_img').each(function(){
		        		$.post(//�대�吏��깅줉
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
		        				
		        				}else{
		        					if(++completecount==$('.add_img').size()){
		        						$('#processform').trigger('submit');
		        					}
		        				}	        				
		        			}
		        		).done(function() {
		        		})
		        		.fail(function() {
		                    alert("�쒕쾭���듭떊 以�臾몄젣媛�諛쒖깮�덉뒿�덈떎");
		        		});
		        		refcount++;
		        	});
					//alert('�꾩넚��);
				}
   		);
        });      
});