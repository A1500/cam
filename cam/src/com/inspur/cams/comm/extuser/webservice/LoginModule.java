package com.inspur.cams.comm.extuser.webservice;

import org.apache.neethi.Assertion;
import org.apache.neethi.Policy;
import org.loushang.ws.AxisFault;
import org.loushang.ws.context.ConfigurationContext;
import org.loushang.ws.description.AxisDescription;
import org.loushang.ws.description.AxisModule;
import org.loushang.ws.modules.Module;

public class LoginModule
  implements Module
{
  public void init(ConfigurationContext paramConfigurationContext, AxisModule paramAxisModule)
    throws AxisFault
  {
  }

  public void engageNotify(AxisDescription paramAxisDescription)
    throws AxisFault
  {
  }

  public void shutdown(ConfigurationContext paramConfigurationContext)
    throws AxisFault
  {
  }

  public void applyPolicy(Policy paramPolicy, AxisDescription paramAxisDescription)
    throws AxisFault
  {
  }

  public boolean canSupportAssertion(Assertion paramAssertion)
  {
    return false;
  }
}