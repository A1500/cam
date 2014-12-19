package com.inspur.cams.comm.informUtil;

import org.loushang.bsp.security.context.BspInfo;
import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.bsp.share.organization.OrganFactory;
import org.loushang.bsp.share.organization.bean.StruView;
import org.loushang.bsp.share.organization.provider.IOrganProvider;
import org.loushang.bsp.share.permit.security.SecurityFactory;
import org.loushang.bsp.share.permit.security.provider.ISecurityProvider;
import org.loushang.next.web.cmd.CommandContext;

public class InformGetSessionInfo
{
  //private static IOrganProvider organProvider = OrganFactory.getIOrganProvider();
//  private static ILocation location = (ILocation)ScaComponentFactory.getService(
 //   ILocation.class, "LocationDomain/LocationDomain");


	private static ISecurityProvider ISecurity=(ISecurityProvider)SecurityFactory.getISecurityProvider();
	private static IOrganProvider organProvider=(IOrganProvider)OrganFactory.getIOrganProvider();

  private static ThreadLocal<BspInfo> _bspInfo = new ThreadLocal();

  public static void setBspInfo(BspInfo bspInfo) {
    _bspInfo.set(bspInfo);
  }

  public static String getUserName()
  {
    BspInfo bspInfo = (_bspInfo.get() == null) ? GetBspInfo.getBspInfo(CommandContext.getRequest()) : (BspInfo)_bspInfo.get();
    return bspInfo.getUserName();
  }

  public static String getUserLoginName()
  {
    BspInfo bspInfo = (_bspInfo.get() == null) ? GetBspInfo.getBspInfo(CommandContext.getRequest()) : (BspInfo)_bspInfo.get();
    return bspInfo.getUserId();
  }

  public static String getUserId()
  {
    BspInfo bspInfo = (_bspInfo.get() == null) ? GetBspInfo.getBspInfo(CommandContext.getRequest()) : (BspInfo)_bspInfo.get();
    String obj = bspInfo.getEmployeeStruId();
    StruView struView = null;
    if ((obj != null) && (!(obj.equals("")))) {
      struView = organProvider.getStruByStruId(obj);
    }

    return ((struView.getOrganId() == null) ? "nobodyid" : (struView == null) ? "nobodyid" : struView.getOrganId());

//	String loginUserId = GetBspInfo.getBspInfo(CommandContext.getRequest()).getUserId();
//	return loginUserId;
  }

  public static String getUserEmpOrganId()
  {
    return getUserId();
  }

  public static String getUserDepOrganId()
  {
    BspInfo bspInfo = (_bspInfo.get() == null) ? GetBspInfo.getBspInfo(CommandContext.getRequest()) : (BspInfo)_bspInfo.get();
    if (bspInfo.getDepartmentOrganId() != null)
    {
      return bspInfo.getDepartmentOrganId();
    }
    return "1";
  }

  public static String getUserDepOrganName()
  {
    BspInfo bspInfo = (_bspInfo.get() == null) ? GetBspInfo.getBspInfo(CommandContext.getRequest()) : (BspInfo)_bspInfo.get();
    if (bspInfo.getDepartmentOrganId() != null)
    {
      return organProvider.getOrganByOrganId(bspInfo.getDepartmentOrganId()).getOrganName();
    }
    return "根机构";
  }

  public static boolean isAdmin()
  {
    BspInfo bspInfo = (_bspInfo.get() == null) ? GetBspInfo.getBspInfo(CommandContext.getRequest()) : (BspInfo)_bspInfo.get();
    return bspInfo.isAdmin();
  }

//  public static Cant getUserCant()
//  {
//    BspInfo info = (_bspInfo.get() == null) ? GetBspInfo.getBspInfo(CommandContext.getRequest()) : (BspInfo)_bspInfo.get();
//    String organId = info.getDepartmentOrganId();
//    Cant cant = location.getCantByOrganId(organId);
//    return cant;
//  }

  public static String getCorporationOrganId()
  {
    BspInfo bspInfo = (_bspInfo.get() == null) ? GetBspInfo.getBspInfo(CommandContext.getRequest()) : (BspInfo)_bspInfo.get();
    return bspInfo.getCorporationOrganId();
  }

  public static String[] getCorporationOrganInfo()
  {
    String userOrganId = getUserId();
    IOrganProvider organProvider = OrganFactory.getIOrganProvider();
    StruView[] strulist = organProvider.getListByOrganId(userOrganId);

    String orgName = "";
    String orgId = "";
    if (strulist.length > 0)
    {
      StruView stru = strulist[0];

      orgName = stru.getCropName();
      orgId = stru.getCropId();
    }
    else
    {
      orgName = "根机构";
      orgId = "1";
    }
    return new String[] { orgId, orgName };
  }

  public static String[] getRootData()
  {
    StruView struView = OrganFactory.getIOrganProvider().getTopMember("00");

    return new String[] { struView.getOrganId(), struView.getOrganName() };
  }

  public static String getUserUnitOrganId()
  {
    BspInfo bspInfo = (_bspInfo.get() == null) ? GetBspInfo.getBspInfo(CommandContext.getRequest()) : (BspInfo)_bspInfo.get();
    String struId = bspInfo.getEmployeeStruId();

    IOrganProvider organProvider = OrganFactory.getIOrganProvider();
    StruView struView = organProvider.getStruByStruId(struId);
    while (Integer.parseInt(struView.getOrganType()) > 3) {
      struView = organProvider.getParent(struId);
      struId = struView.getStruId();
    }
    return struView.getOrganId();
  }

  public static String getUserParentsOrganIdList()
  {
    BspInfo bspInfo = (_bspInfo.get() == null) ? GetBspInfo.getBspInfo(CommandContext.getRequest()) : (BspInfo)_bspInfo.get();
    StringBuffer sb = new StringBuffer();
    String struId = bspInfo.getEmployeeStruId();

    if (struId == null) return "1";
    IOrganProvider organProvider = OrganFactory.getIOrganProvider();
    StruView struView = organProvider.getStruByStruId(struId);
    while (true) {
      struView = organProvider.getParent(struId);
      struId = struView.getStruId();
      if ("rootId".equals(struView.getParentId())) {
        break;
      }
      sb.append(struView.getOrganId()).append(",");
    }
    if (sb.length() > 1) sb.deleteCharAt(sb.length() - 1);
    return sb.toString();
  }
}