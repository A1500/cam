package com.inspur.cams.marry.base.domain.support;

import java.util.List;

import org.loushang.bsp.organization.domain.IStruDomain;
import org.loushang.bsp.permit.pap.user.data.UserView;
import org.loushang.bsp.permit.pap.user.domain.IUserDomain;
import org.loushang.bsp.share.organization.OrganFactory;
import org.loushang.bsp.share.organization.bean.StruView;
import org.loushang.bsp.util.DateUtil;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.menuconfig.dao.IPubMenuConfigDao;
import com.inspur.cams.comm.menuconfig.data.PubMenuConfig;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.PhotoUtil;
import com.inspur.cams.marry.base.dao.IMrmBasePersonDao;
import com.inspur.cams.marry.base.data.MrmBasePerson;
import com.inspur.cams.marry.base.domain.IMrmBasePersonDomain;

/**
 * 婚登用户增加
 * @author shgtch
 * @date 2011-12-5
 */
public class MrmBasePersonDomain implements IMrmBasePersonDomain{
	
	@Reference
	private IMrmBasePersonDao mrmBasePersonDao;
	
	@Reference
	IStruDomain struDomain;
	
	@Reference
	private IUserDomain userDomain;
	
	@Reference
	private IPubMenuConfigDao pubMenuConfigDao;
	
	/**
	 * 查询
	 */
	public DataSet query(ParameterSet set) {
		return mrmBasePersonDao.query(set);
	}
	
	/**
	 * 增加婚登用户
	 */
	public void insert(MrmBasePerson mrmBasePerson) {
		
		// 获取上级bsp结构信息
		StruView[] struViewList;
		if(mrmBasePerson.getParentOrganId()!=null && !"".equals(mrmBasePerson.getParentOrganId())){
			//System.out.println("111:"+mrmBasePerson.getParentOrganId());
			 	struViewList = OrganFactory.getIOrganProvider().getListByOrganId(mrmBasePerson.getParentOrganId(), BspUtil.DEFAULT_STRU_TYPE);
		}else{
			 	struViewList = OrganFactory.getIOrganProvider().getListByOrganId(BspUtil.getCorpOrganId(), BspUtil.DEFAULT_STRU_TYPE);
		}
			if (struViewList.length <= 0) {
				throw new RuntimeException("未找到该员工的单位");
			}
		ParameterSet pset = new ParameterSet();
		pset.setParameter("USER_ID", mrmBasePerson.getLoginid());
		DataSet ds = userDomain.queryUser(pset);
		if(ds.getCount() ==0){
			StruView parentStruView = struViewList[0];
			// 增加bsp组织结构信息
			StruView struView = new StruView();
			struView.setOrganCode(mrmBasePerson.getPersonId());
			struView.setOrganName(mrmBasePerson.getName());
			struView.setShortName(mrmBasePerson.getName());
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
			userView.setUserId(mrmBasePerson.getLoginid());
			userView.setUserTypeId("00");
			userView.setUserName(mrmBasePerson.getName());
			userView.setPassWord(mrmBasePerson.getPwd());
			userView.setIsSys("0");
			userView.setAccountStatus("11");
			userView.setCorporationId(parentStruView.getOrganId());
			userView.setDepartmentId(parentStruView.getOrganId());
			userView.setEmployeeId(userStruView.getStruId());
			userView.setMaxSessionNumber(1);
			userView.setIsUseIP("0");
			userView.grantedRole(mrmBasePerson.getRoleId());
			userView.setCreateTime(DateUtil.getCurrentDateTime());
			userDomain.addUser(userView);
			
			// 维护用户角色
			Record record = new Record();
			record.set("roleId", mrmBasePerson.getRoleId());
			Record[] addRoles = new Record[] {record};
			Record[] delRoles = new Record[0];
			userDomain.updateUserRole(userView, addRoles, delRoles, null);
			
			//插入个性化菜单
			PubMenuConfig pubMenuConfig = new PubMenuConfig();
			pubMenuConfig.setOrganCode(mrmBasePerson.getPersonId());
			pubMenuConfig.setOrganName(mrmBasePerson.getName());
			pubMenuConfig.setMenuTypeId("0000000012");
			pubMenuConfig.setMenuTypeName("婚姻登记菜单");
			pubMenuConfig.setDealPersonId(BspUtil.getEmpOrganId());
			pubMenuConfig.setDealPersonName(BspUtil.getEmpOrgan().getOrganName());
			pubMenuConfig.setDealTime(DateUtil.GetCurrentTime());
			pubMenuConfigDao.insert(pubMenuConfig);
		}else{
			userDomain.updatePassword(mrmBasePerson.getPersonId(),mrmBasePerson.getPwd());
		}
		// 增加用户信息
		mrmBasePersonDao.update(mrmBasePerson);
	}
	
	
	/**
	 * 初始化所有默认登录账号
	 */
	public void insertAll(MrmBasePerson mrmBasePerson) {
		
		// 获取上级bsp结构信息
		StruView[] struViewList;
		if(mrmBasePerson.getParentOrganId()!=null && !"".equals(mrmBasePerson.getParentOrganId())){
			//System.out.println("1111:"+mrmBasePerson.getParentOrganId());
			 	struViewList = OrganFactory.getIOrganProvider().getListByOrganId(mrmBasePerson.getParentOrganId(), BspUtil.DEFAULT_STRU_TYPE);
		}else{
			 	struViewList = OrganFactory.getIOrganProvider().getListByOrganId(BspUtil.getCorpOrganId(), BspUtil.DEFAULT_STRU_TYPE);
		}
			if (struViewList.length <= 0) {
				throw new RuntimeException("未找到该员工的单位");
			}
		ParameterSet pset = new ParameterSet();
		pset.setParameter("USER_ID", mrmBasePerson.getLoginid());
		DataSet ds = userDomain.queryUser(pset);
		if(ds.getCount() ==0){
			StruView parentStruView = struViewList[0];
			// 增加bsp组织结构信息
			StruView struView = new StruView();
			struView.setOrganCode(mrmBasePerson.getPersonId());
			struView.setOrganName(mrmBasePerson.getName());
			struView.setShortName(mrmBasePerson.getName());
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
			userView.setUserId(mrmBasePerson.getLoginid());
			userView.setUserTypeId("00");
			userView.setUserName(mrmBasePerson.getName());
			userView.setPassWord(mrmBasePerson.getPwd());
			userView.setIsSys("0");
			userView.setAccountStatus("11");
			userView.setCorporationId(parentStruView.getOrganId());
			userView.setDepartmentId(parentStruView.getOrganId());
			userView.setEmployeeId(userStruView.getStruId());
			userView.setMaxSessionNumber(1);
			userView.setIsUseIP("0");
			userView.grantedRole(mrmBasePerson.getRoleId());
			userView.setCreateTime(DateUtil.getCurrentDateTime());
			userDomain.addUser(userView);
			
			// 维护用户角色
			Record record = new Record();
			record.set("roleId", mrmBasePerson.getRoleId());
			Record[] addRoles = new Record[] {record};
			Record[] delRoles = new Record[0];
			userDomain.updateUserRole(userView, addRoles, delRoles, null);
		}else{
			userDomain.updatePassword(mrmBasePerson.getPersonId(),mrmBasePerson.getPwd());
		}
		// 增加用户信息
		mrmBasePersonDao.insert(mrmBasePerson);
	}
	
	/**
	 * 添加婚登人员信息
	 */
	public void insertPerson(MrmBasePerson mrmBasePerson){
		//照片
		mrmBasePerson.setPhoto(makePhotoId(mrmBasePerson));
		//签名
		mrmBasePerson.setQmName(makeQmNameId(mrmBasePerson));
		mrmBasePersonDao.insert(mrmBasePerson);
	}
	
	/**
	 * 修改婚登用户
	 * @param mrmBasePerson
	 */
	public void update(MrmBasePerson mrmBasePerson) {
		//照片
		String photo = mrmBasePerson.getPhoto();
		String photoTemp = mrmBasePerson.getPhotoTemp();
		mrmBasePerson.setPhoto(updatePhoto(photo,photoTemp));
		//签名
		mrmBasePerson.setQmName(updateQm(mrmBasePerson.getQmName(),mrmBasePerson.getQmTemp()));
		mrmBasePersonDao.update(mrmBasePerson); 
	}

	/**
	 * 批量修改婚登用户
	 */
	public void batchUpdate(List<MrmBasePerson> list){
		mrmBasePersonDao.batchUpdate(list);
	}
	
	/**
	 * 删除婚登用户
	 */
	public void delete(String delid){
		mrmBasePersonDao.delete(delid);
	}

	public void insertBspUser(MrmBasePerson mrmBasePerson) {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * 插入照片
	 */
	private String makePhotoId(MrmBasePerson mrmBasePerson) {
		//保存照片
		String base64Code = mrmBasePerson.getPhotoTemp();
		String photo = "";
		if (null != base64Code && !"".equals(base64Code)) {
			// 保存图片到表 COM_PHOTO 中，并返回该图片的主键
			photo = PhotoUtil.savePhoto(base64Code);
			return photo;
		}
		return null;
	}
	/**
	 * 插入签名
	 */
	private String makeQmNameId(MrmBasePerson mrmBasePerson) {
		//保存照片
		String base64Code = mrmBasePerson.getQmTemp();
		String qmName = "";
		if (null != base64Code && !"".equals(base64Code)) {
			// 保存图片到表 COM_PHOTO 中，并返回该图片的主键
			qmName = PhotoUtil.savePhoto(base64Code);
			return qmName;
		}
		return null;
	}
	/**
	 * 保存照片并返回照片Id
	 */
	public String savePhoto(String photoTemp) {
		String photo = "";
		if (null != photoTemp && !"".equals(photoTemp)) {
			// 保存图片到表 COM_PHOTO 中，并返回该图片的主键
			photo = PhotoUtil.savePhoto(photoTemp);
		}
		return photo;
	}
	
	/**
	 * 更新照片
	 */
	private String updatePhoto(String photo, String photoTemp) {
		return mrmBasePersonDao.updatePhoto(photo, photoTemp);
	}
	/**
	 * 更新签名
	 */
	private String updateQm(String qmName, String qmTemp) {
		return mrmBasePersonDao.updateQm(qmName, qmTemp);
	}
	/**
	 * 查询登记人员报名信息
	 */
	public DataSet examApplyDataSet(ParameterSet set) {
		// TODO Auto-generated method stub
		return mrmBasePersonDao.examApplyDataSet(set);
	}
	/**
	 * 升为颁证员
	 */
	public void updateBzy(MrmBasePerson mrmBasePerson) {
		mrmBasePersonDao.updateBzy(mrmBasePerson);
		
	}

	public void updateBzyzh(MrmBasePerson person) {
		// TODO Auto-generated method stub
		mrmBasePersonDao.updateBzyzh(person);
	}

	public void updateCertificate(MrmBasePerson person) {
		// TODO Auto-generated method stub
		mrmBasePersonDao.updateCertificate(person);
	}
}
