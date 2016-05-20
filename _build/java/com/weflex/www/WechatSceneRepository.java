package com.theweflex.www;

import com.strongloop.android.loopback.ModelRepository;

public class WechatSceneRepository extends ModelRepository<WechatScene>
{
  public WechatSceneRepository() {
      super("scene", WechatScene.class);
  }

}
