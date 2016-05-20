package com.theweflex.www;

import java.util.Date;
import com.strongloop.android.loopback.Model;
import java.util.ArrayList;

public class WechatScene extends Model
{
  
  private String eventType;
  
  private String openid;
  
  private String sceneId;
  
  private Date created;
  
  private Object payload;
  

  

  
  public void setEventtype(String eventType) {
    this.eventType = eventType;
  }
  
  
  public String getEventtype() {
    return this.eventType;
  }

  
  public void setOpenid(String openid) {
    this.openid = openid;
  }
  
  
  public String getOpenid() {
    return this.openid;
  }

  
  public void setSceneid(String sceneId) {
    this.sceneId = sceneId;
  }
  
  
  public String getSceneid() {
    return this.sceneId;
  }

  
  public void setCreated(Date created) {
    this.created = created;
  }
  
  
  public Date getCreated() {
    return this.created;
  }

  
  public void setPayload(Object payload) {
    this.payload = payload;
  }
  
  
  public Object getPayload() {
    return this.payload;
  }

  

  

}
