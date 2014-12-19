package com.inspur.cams.fis.base.cmd;

import java.util.*;

import org.loushang.bsp.organization.dao.IPubOrganDao;
import org.loushang.bsp.organization.dao.IPubStruTypeDao;
import org.loushang.bsp.organization.dao.OrganDao;
import org.loushang.bsp.organization.dao.OrganTypeDao;
import org.loushang.bsp.organization.data.PubStruRule;
import org.loushang.bsp.organization.data.PubStruType;
import org.loushang.bsp.organization.domain.IStruDomain;
import org.loushang.bsp.organization.domain.IStruRuleDomain;
import org.loushang.bsp.permit.pap.user.dao.IUserDao;
import org.loushang.bsp.permit.pap.user.dao.IUserDataPermitDao;
import org.loushang.bsp.permit.pap.user.data.User;
import org.loushang.bsp.permit.pap.user.data.UserDataPermit;
import org.loushang.bsp.permit.pap.user.data.UserView;
import org.loushang.bsp.permit.pap.user.domain.IUserDomain;
import org.loushang.bsp.share.organization.OrganFactory;
import org.loushang.bsp.share.organization.bean.OrganType;
import org.loushang.bsp.share.organization.bean.StruView;
import org.loushang.bsp.util.BspConstants;
import org.loushang.bsp.util.DateUtil;
import org.loushang.bsp.util.uuid.UUIDGenerator;
import org.loushang.next.core.SystemException;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.menuconfig.dao.IPubMenuConfigDao;
import com.inspur.cams.comm.menuconfig.data.PubMenuConfig;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.fis.base.data.FisFuneralOrganManage;
import com.inspur.cams.fis.base.domain.IFisFuneralOrganManageDomain;

/**
 * @title:FisFuneralOrganManageCommand
 * @description:
 * @author:
 * @since:2012-04-03
 * @version:1.0
*/
public class FisFuneralOrganManageCmd extends BaseAjaxCommand{
	private IFisFuneralOrganManageDomain service = ScaComponentFactory.getService(IFisFuneralOrganManageDomain.class,
	"FisFuneralOrganManageDomain/FisFuneralOrganManageDomain");
	
	private IStruDomain struDomain = (IStruDomain)ScaComponentFactory.getService(IStruDomain.class, "StruDomain/StruDomain");
	
	private IPubStruTypeDao pubStruTypeDao = (IPubStruTypeDao)ScaComponentFactory.getService(IPubStruTypeDao.class, "PubStruTypeDao/PubStruTypeDao");

	private IStruRuleDomain struRuleDomain = (IStruRuleDomain)ScaComponentFactory.getService(IStruRuleDomain.class, "StruRuleDomain/StruRuleDomain");
	
	private OrganTypeDao organTypeDao = (OrganTypeDao)DaoFactory.getDao("org.loushang.bsp.organization.dao.OrganTypeDao");
	
	private IUserDomain userDomain = (IUserDomain)ScaComponentFactory.getService(IUserDomain.class, "UserDomain/UserDomain");
		
	private IUserDao userDao = (IUserDao)DaoFactory.getDao("org.loushang.bsp.permit.pap.user.dao.jdbc.UserJdbcDao");

	private IPubOrganDao organDao = (IPubOrganDao)DaoFactory.getDao("org.loushang.bsp.organization.dao.OrganDao");

	private IUserDataPermitDao userDataPermitDao = (IUserDataPermitDao)DaoFactory.getDao("org.loushang.bsp.permit.pap.user.dao.jdbc.UserDataPermitJdbcDao");
	
	private IPubMenuConfigDao pubMenuConfigDao = (IPubMenuConfigDao)DaoFactory.getDao("com.inspur.cams.comm.menuconfig.dao.PubMenuConfigDao");;

	//各种角色ID
	public final static String FUNERAL_ROLE = "FISROLE_FUNERAL";
	public final static String EMPLACING_ROLE = "FISROLE_EMPLACING";
	public final static String CEMETERY_ROLE = "FISROLE_CEMETERY";
	
	//个性化菜单编码
	public final static String CUSTOM_MENU_TYPE_ID = "0000000008";
	public final static String CUSTOM_MENU_TYPE_NAME = "殡葬民政主管部门菜单";
	
	
	@Trans
	public void update(){
		Record data = (Record) getParameter("record");
		FisFuneralOrganManage bean = (FisFuneralOrganManage) data.toBean(FisFuneralOrganManage.class);
		String oldOrganCode = (String) getParameter("oldOrganCode");
		if(bean.getOrganCode().equals(oldOrganCode)){
			service.update(bean);
		}
//		else if(!service.queryUserIfExist(bean.getOrganCode())){
//			service.deleteById(oldOrganCode);
//			service.insert(bean);
//		}
		else{
			setReturn("error", "用户名已存在！");
		}
	}
	@Trans
	public void insert() {
		ParameterSet pset2 = getParameterSet();
		Record data = (Record) getParameter("record");
		FisFuneralOrganManage bean = (FisFuneralOrganManage) data.toBean(FisFuneralOrganManage.class);
		if(!service.queryUserIfExist(bean.getOrganCode())){
			service.insert(bean);
			
/*			//获取上级OrganId
			String parentOrganId="";
			ParameterSet psetInner = new ParameterSet();
			psetInner.setParameter("ORGAN_CODE@=@String", bean.getParentOrganCode());
			DataSet organDs = organDao.query(psetInner);
			if(organDs.getCount() > 0) {
				Record rec = organDs.getRecord(0);
				parentOrganId=(String)rec.get("organId");
			}
			
			// 获取上级bsp结构信息
			StruView[] struViewList = OrganFactory.getIOrganProvider().getListByOrganId(parentOrganId, BspUtil.DEFAULT_STRU_TYPE);
			
			if (struViewList.length <= 0) {
				throw new RuntimeException("未找到该员工的单位");
			}
			
			StruView parentStruView = struViewList[0];
			// 增加bsp组织结构信息
			StruView struView = new StruView();
			struView.setOrganCode(bean.getOrganCode());
			struView.setOrganName(bean.getUnitName());
			struView.setShortName(bean.getUnitName());
			struView.setOrganType(BspUtil.EMPLOYEE);
			struView.setOrganTypeName(BspUtil.EMPLOYEE_CN);
			parentStruView.setDeptId(parentStruView.getOrganId());
			parentStruView.setCropId(parentStruView.getOrganId());
			parentStruView.setPrincipalId(parentStruView.getOrganId());
			struView.setDeptId(parentStruView.getOrganId());
			struView.setCropId(parentStruView.getOrganId());
			struView.setPrincipalId(parentStruView.getOrganId());
			struView.setInUseOrgan("1");
			struView.setInUseStru("1");
			String struId = struDomain.create(struView, parentStruView);
			StruView userStruView = struDomain.getStruView(struId);
			// 增加bsp用户信息
			UserView userView = new UserView();
			userView.setUserId(bean.getOrganCode());
			userView.setUserTypeId("00");
			userView.setUserName(bean.getUnitName());
			userView.setPassWord("000000");
			userView.setIsSys("0");
			userView.setAccountStatus("11");
			userView.setCorporationId(parentStruView.getOrganId());
			userView.setDepartmentId(parentStruView.getOrganId());
			userView.setEmployeeId(userStruView.getStruId());
			userView.setMaxSessionNumber(1);
			userView.setIsUseIP("0");
			userView.grantedRole(FUNERAL_ROLE);
			userView.setCreateTime(DateUtil.getCurrentDateTime());
			userDomain.addUser(userView);
			
			// 维护用户角色
			Record record = new Record();
			record.set("roleId", FUNERAL_ROLE);
			Record[] addRoles = new Record[] {record};
			Record[] delRoles = new Record[0];
			userDomain.updateUserRole(userView, addRoles, delRoles, null);
			
			//插入个性化菜单
			PubMenuConfig pubMenuConfig = new PubMenuConfig();
			pubMenuConfig.setOrganCode(bean.getOrganCode());
			pubMenuConfig.setOrganName(bean.getUnitName());
			pubMenuConfig.setMenuTypeId(CUSTOM_MENU_TYPE_ID);
			pubMenuConfig.setMenuTypeName(CUSTOM_MENU_TYPE_NAME);
			pubMenuConfig.setDealPersonId(BspUtil.getEmpOrganId());
			pubMenuConfig.setDealPersonName(BspUtil.getEmpOrgan().getOrganName());
			pubMenuConfig.setDealTime(DateUtil.GetCurrentTime());
			pubMenuConfigDao.insert(pubMenuConfig);*/
		}else{
			setReturn("error", "用户名已存在！");
		}
	}
	
	private void checkOrganType(List list, StruView struview)
    {
        if(list != null && list.size() > 0)
        {
            boolean flag = false;
            int i = 0;
            do
            {
                if(i >= list.size())
                    break;
                PubStruRule pubstrurule = (PubStruRule)list.get(i);
                if(struview.getOrganType().equals(pubstrurule.getTargetRef()))
                {
                    flag = true;
                    break;
                }
                i++;
            } while(true);
            if(!flag)
                throw new RuntimeException((new StringBuilder()).append("\u8BE5\u6210\u5458\u4E0B\u4E0D\u80FD\u518D\u6DFB\u52A0\u7C7B\u578B\u4E3A ").append(struview.getOrganTypeName()).append(" \u7684\u4E0B\u7EA7\u6210\u5458.").toString());
            else
                return;
        } else
        {
            throw new RuntimeException("\u8BE5\u6210\u5458\u4E0B\u4E0D\u80FD\u518D\u6DFB\u52A0\u4E0B\u7EA7\u6210\u5458.");
        }
    }
	
	private void setGrantedRoles(Record record, UserView userview)
    {
        if(record.get("grantedRoles") != null && !record.get("grantedRoles").equals(""))
        {
            String as[] = record.get("grantedRoles").toString().split(",");
            String as1[] = as;
            int i = as1.length;
            for(int j = 0; j < i; j++)
            {
                String s = as1[j];
                userview.grantedRole(s);
            }

        }
    }
	private void setUserDataPermits(UserView userview,ParameterSet pset)
    {
        Record arecord[] = (Record[])(Record[])(pset.getParameter("userDataPermitRecords"));
        String as[] = (String[])(String[])(pset.getParameter("struIds"));
        String as1[] = (String[])(String[])(pset.getParameter("organIds"));
        String as2[] = (String[])(String[])(pset.getParameter("organTypes"));
        boolean flag = false;
        if(as != null && as.length > 0)
            flag = true;
        if(arecord == null && !flag)
            return;
        ArrayList arraylist = new ArrayList();
        UUIDGenerator uuidgenerator = new UUIDGenerator();
        if(arecord != null)
        {
            for(int i = 0; i < arecord.length; i++)
            {
                UserDataPermit userdatapermit = (UserDataPermit)arecord[i].toBean(UserDataPermit.class);
                if(!BspConstants.userId_Case_Sensitive)
                    userdatapermit.setUserId(userdatapermit.getUserId().toUpperCase());
                if(userdatapermit.getState() == 1)
                {
                    ParameterSet parameterset = new ParameterSet();
                    parameterset.setParameter("USER_ID", userview.getUserId());
                    parameterset.setParameter("OBJECT_VALUE", userdatapermit.getObjectValue());
                    DataSet dataset = userDataPermitDao.query(parameterset);
                    if(dataset.getCount() > 0)
                        throw new RuntimeException((new StringBuilder()).append("\u7EC4\u7EC7\u6743\u9650\u3010").append(userdatapermit.getObjectName()).append("\u3011\u5728\u5217\u8868\u4E2D\u5DF2\u7ECF\u5B58\u5728").toString());
                    if(flag)
                    {
                        for(int j = 0; j < as.length; j++)
                            if(!userdatapermit.getStruId().equals(as[j]));

                    }
                    userdatapermit.setUserDataPermitId((String)uuidgenerator.getNextSeqId(30));
                }
                arraylist.add(userdatapermit);
            }

        }
        if(flag)
            arraylist.addAll(createDefaultUserDataPermit(as, as1, as2, userview.getUserId(), uuidgenerator));
        userview.setUserDataPermitList(arraylist);
    }
	private List createDefaultUserDataPermit(String as[], String as1[], String as2[], String s, UUIDGenerator uuidgenerator)
    {
        ArrayList arraylist = new ArrayList();
        for(int i = 0; i < as.length; i++)
            if(i == 0 || !as[i].equals(as[0]))
            {
                UserDataPermit userdatapermit = new UserDataPermit();
                userdatapermit.setState(1);
                userdatapermit.setUserDataPermitId((String)uuidgenerator.getNextSeqId(30));
                userdatapermit.setUserId(s);
                userdatapermit.setObjectValue(as1[i]);
                userdatapermit.setDataTypeCode(as2[i]);
                userdatapermit.setIsDefault("1");
                userdatapermit.setStruId(as[i]);
                userdatapermit.setStruType("00");
                userdatapermit.setScopeType("0");
                userdatapermit.setStartTime("20000101 00:00:00");
                userdatapermit.setEndTime("99991231 23:59:59");
                arraylist.add(userdatapermit);
            }

        return arraylist;
    }
}
