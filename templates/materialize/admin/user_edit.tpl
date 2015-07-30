<{extends file="header.tpl"}><{block name="title" prepend}>用户管理 - <{/block}><{block name="contents"}>
<div class="had-container">
   <{include file='admin/nav.tpl'}>

<div class="section no-pad-bot" id="index-banner">
    <div class="container ">
      <h5 class="white-text">
          用户管理
          <small>User Manage</small>
      </h5>

        <div class="section">
          <div class="row card-panel color-panel light-blue lighten-5 z-depth-2 hoverable">
            <div class="col s12">
              <div class="card-panel darken-1 hoverable">
                      <span class="white-text">
                      <h5 class="header black-text">编辑用户</h5>
                      <div class="black-text">
                          <form role="form" method="post" action="javascript:void(0);">
                              <div class="input-field">
                                <input type="text" name="user_uid" id="user_uid" value="<{$uid}>" class="validate">
                                <label for="user_uid">ID: <{$uid}></label>
                              </div>
                              <div class="input-field">
                                <input type="text" name="user_name" id="user_name" value="<{$rs['user_name']}>" class="validate">
                                <label for="user_name">用户名</label>
                              </div>
                              <div class="input-field">
                                <input type="text" name="user_email" id="user_email" value="<{$rs['email']}>" class="validate">
                                <label for="user_email">用户邮箱</label>
                              </div>
                              <div class="input-field">
                                <input class="form-control" id="user_pass_hidden" value="<{$rs['pass']}>" style="display:none">
                                <input type="text" name="user_pass" id="user_pass" class="validate">
                                <label for="user_pass">用户密码 新密码(不修改请留空)</label>
                              </div>
                              <div class="input-field">
                                <input type="text" name="user_passwd" id="user_passwd" value="<{$rs['passwd']}>" class="validate">
                                <label for="user_passwd">连接密码</label>
                              </div>
                              <div class="input-field">
                                <input type="hidden" id="transfer_enable_hidden" value="<{$rs['transfer_enable']}>" style="display:none">
                                <input type="text" name="transfer_enable" id="transfer_enable" value="<{\Ss\Etc\Comm::flowAutoShow($rs['transfer_enable'])}>" class="validate">
                                <label for="transfer_enable">设置流量 单位为GB</label>
                              </div>
                              <div class="input-field">
                                <input  class="form-control" id="invite_num_hidden" value="<{$rs['invite_num']}>" style="display:none">
                                <input type="text" name="invite_num" id="invite_num" value="<{$rs['invite_num']}>" class="validate">
                                <label for="invite_num">邀请码数量</label>
                              </div>
                                  <button id="Submit" type="submit" class="btn waves-effect waves-light light-blue lighten-1">修改</button>
                          </form>
                      </div>
                 </span> 
                </div>
            </div>
          </div>
        </div>
      </div>
    </div>
</div>


<div id="msg-success" class="modal" style="z-index: 1003; opacity: 1; transform: scaleX(1); top: 5%;" title="点击关闭" onclick="$('#msg-success').closeModal();">
    <div class="modal-content" id="ok-close">
        <h4><i class="mdi-image-tag-faces" style="font-size: 1em;"></i>成功了!</h4>
        <p id="msg-success-p" style=" COLOR: deepskyblue; FONT-SIZE: x-large;"></p>
        <!-- <iframe id="tmp_downloadhelper_iframe" style="display: none;"></iframe> -->
    </div>
    <div class="modal-footer">
         <a href="#!" onclick="$('#msg-success').closeModal();" class="modal-action modal-close btn waves-light light-blue lighten-1 modal-action modal-close waves-effect waves-red">关闭</a>
    </div>
</div>
 <div id="msg-error" class="modal" style="z-index: 1003; opacity: 1; transform: scaleX(1); top: 5%;" title="点击关闭" onclick="$('#msg-error').closeModal();">
      <div class="modal-content" id="error-close">
            <h4><i class="mdi-alert-error" style="font-size: 1em;"></i>出错了!</h4>
            <p id="msg-error-p" style=" COLOR: RED; FONT-SIZE: x-large;"> </p>
            <!-- <iframe id="tmp_downloadhelper_iframe" style="display: none;"></iframe> -->
      </div>
  <div class="modal-footer">
     <a href="#!" onclick="$('#msg-error').closeModal();" class="modal-action modal-close btn waves-light light-blue lighten-1 modal-action modal-close waves-effect waves-red">关闭</a>
  </div>
</div>
<{include file='footer.tpl'}> <{/block}> <{* 以上继承内容到父模板header.tpl 中的 contents *}>
<{extends file="Public_javascript.tpl" append}> <{block name="javascript"}>
<script>
    $("#msg-success").closeModal();
    $("#msg-error").closeModal();
</script>
<script>
    $(document).ready(function(){
        $("#Submit").click(function(){
            $.ajax({
                type:"POST",
                url:"_user_edit.php",
                dataType:"json",
                data:{
                    user_uid: $("#user_uid").val(),
                    user_name: $("#user_name").val(),
                    user_email: $("#user_email").val(),
                    user_email_hidden: $("#user_email_hidden").val(),
                    user_pass: $("#user_pass").val(),
                    user_pass_hidden: $("#user_pass_hidden").val(),
                    user_passwd: $("#user_passwd").val(),
                    transfer_enable: $("#transfer_enable").val(),
                    transfer_enable_hidden: $("#transfer_enable_hidden").val(),
                    invite_num: $("#invite_num").val(),
                    invite_num_hidden: $("#invite_num_hidden").val()
                },
                success:function(data){
                    if(data.ok){
                        $("#msg-error").closeModal();
                        $("#msg-success").openModal();
                        $("#msg-success-p").html(data.msg);
                        window.setTimeout("location.href='user.php'", 2000);
                    }else{
                        $("#msg-error").openModal();
                        $("#msg-error-p").html(data.msg);
                    }
                },
                error:function(jqXHR){
                    $("#msg-error").openModal();
                    $("#msg-error-p").html("发生错误："+jqXHR.status);
                }
            })
        })
        $("#ok-close").click(function(){
            $("#msg-success").closeModal();
        })
        $("#error-close").click(function(){
            $("#msg-error").closeModal();
        })
    })
</script><{/block}> <{* 以上继承内容到父模板 Public_javascript.tpl 中的 javascript *}>