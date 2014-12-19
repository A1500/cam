package com.inspur.sdmz.apply.domain.support;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;

import org.loushang.bsp.security.context.BspInfo;
import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.bsp.share.organization.OrganFactory;
import org.loushang.bsp.share.organization.bean.OrganView;
import org.loushang.bsp.share.organization.provider.IOrganProvider;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.sdmz.apply.dao.ISamApplyDao;
import com.inspur.sdmz.apply.dao.ISamApplyHandleDao;
import com.inspur.sdmz.apply.data.SamApply;
import com.inspur.sdmz.apply.data.SamApplyHandle;
import com.inspur.sdmz.apply.domain.ISamApplyDomain;
import com.inspur.sdmz.comm.util.DateUtil;
import com.inspur.sdmz.comm.util.IdHelp;

/*
 * 业务受理对应domain实现
 */

public class SamApplyDomain implements ISamApplyDomain {
	@Reference(name = "samapplyDao")
	private ISamApplyDao samapplyDao;
	@Reference(name = "samapplyHandleDao")
	private ISamApplyHandleDao samapplyHandleDao;

	/**
	 * 业务查询
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return getSamApplyDao().query(pset);
	}
	
	/**
	 * 办理历史业务查询
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet ywlsQuery(ParameterSet pset) {
		return samapplyHandleDao.query(pset);
	}
	
	/**
	 * 保存业务
	 * 
	 * @param apply 业务申请对象 area：区用户的行政区划organCode
	 */
	public void saveSamApply(SamApply samapply,String area) {
		BspInfo bspInfo = GetBspInfo.getBspInfo();

		// 添加业务申请ID
		String applyId = IdHelp.getUUID30();
		samapply.setApplyId(applyId);

		// 生成当日日期YYYY-MM-DD
		String today=DateUtil.getDay();
		samapply.setApplyDate(today);
		
		// 应办截止日期为申请日期之后10个工作日
		// getDate()方法实现在下面
		String aftertoday = getDate(10);
		samapply.setAgendaDeadline(aftertoday);

		// 添加受理人姓名,ID
		samapply.setAcceptPeople(bspInfo.getUserName());
		samapply.setAcceptId(bspInfo.getUserId());

		// 添加受理单位区划，单位名称，单位ID
		// 添加当前办理单位区划，单位名称，单位ID 因为是第一次录入所以为了查看当前单位能够看到的受理业务
		IOrganProvider op = OrganFactory.getIOrganProvider();
		OrganView org = op.getOrganByOrganId(bspInfo.getCorporationOrganId());
		String orgName=org.getOrganName();
		String orgCode=org.getOrganCode();
		samapply.setAcceptOrgArea(orgCode);
		samapply.setAcceptOrgName(orgName);
		samapply.setAcceptOrg(bspInfo.getCorporationOrganId());
		samapply.setCurrentOrgArea(orgCode);
		samapply.setCurrentOrgName(orgName);
		samapply.setCurrentOrg(bspInfo.getCorporationOrganId());

		// 添加是否回访
		samapply.setReturnVisit("0");

		// 根据页面单选按钮传过来的，办理完结，上传上级，上传平级
		if (samapply.getHandleResult().equals("0")) {
			samapply.setHandleSign(samapply.getAgreeState());

		} else if (samapply.getHandleResult().equals("1")) {
			
			
			if(samapply.getStreet()==null)
			{
				samapply.setCurrentOrg("O0000000"+area);
				OrganView orgSjdw = op.getOrganByOrganId("O0000000"+area);
				samapply.setCurrentOrgName(orgSjdw.getOrganName());
				samapply.setCurrentOrgArea(orgSjdw.getOrganCode());
			}else
			{
			samapply.setCurrentOrg("O0000000"+samapply.getStreet());
			OrganView orgSjdw = op.getOrganByOrganId("O0000000"+samapply.getStreet());
			samapply.setCurrentOrgName(orgSjdw.getOrganName());
			samapply.setCurrentOrgArea(orgSjdw.getOrganCode());
			}
			samapply.setHandleSign("1");
			
			
		}  else if (samapply.getHandleResult().equals("4")) {
			samapply.setHandleSign("0");
			
		}

		// 从表信息
		SamApplyHandle samapplyHandle = new SamApplyHandle();
		String historyId = applyId.substring(25, 30);
		samapplyHandle.setHistoryId(today + historyId);
		samapplyHandle.setApplyId(applyId);
		samapplyHandle.setHandleOpinion(samapply.getHandleOpinion());
		samapplyHandle.setHandlePeople(bspInfo.getUserName());
		samapplyHandle.setHandleId(IdHelp.getUUID30());
		samapplyHandle.setHandleOrgName(orgName);
		samapplyHandle.setHandleOrgArea(orgCode);
		samapplyHandle.setHandleOrg(bspInfo.getCorporationOrganId());
		String todayTime=DateUtil.getTime();
		samapplyHandle.setHandleTime(todayTime);
		samapplyHandle.setHandleState(samapply.getHandleResult());

		// 双表信息插入
		this.samapplyDao.insert(samapply);
		this.samapplyHandleDao.insert(samapplyHandle);
		
	}
	
	/**
	 * 更新业务
	 * 
	 * @param samapply 业务申请表对象 ，area: 区用户的行政区划organCode;
	 */
	@Trans
	public void updateSamApply(SamApply samapply,String area) {
		
		BspInfo bspInfo = GetBspInfo.getBspInfo();
		IOrganProvider op = OrganFactory.getIOrganProvider();
		
		//根据受理结果判断各种插入信息
		String sljg=samapply.getHandleResult();
		String nowTime=DateUtil.getDay();
		int rec=nowTime.compareTo(samapply.getAgendaDeadline());
		if(sljg.equals("0")){
			if(rec>0)
			{
				samapply.setHandleSign("4");
			}else{
			samapply.setHandleSign(samapply.getAgreeState());
			}
		}else if (samapply.getHandleResult().equals("1")) {
			if(rec>0)
			{
			samapply.setHandleSign("4");
			}else{
			samapply.setHandleSign("1");
			}
			if(samapply.getStreet()==null){
				samapply.setCurrentOrg("O0000000"+area);
				
				OrganView orgSjdw = op.getOrganByOrganId("O0000000"+area);
				samapply.setCurrentOrgName(orgSjdw.getOrganName());
				samapply.setCurrentOrgArea(orgSjdw.getOrganCode());
			}else{
				samapply.setCurrentOrg("O0000000"+samapply.getStreet());
				
				OrganView orgSjdw = op.getOrganByOrganId("O0000000"+samapply.getStreet());
				samapply.setCurrentOrgName(orgSjdw.getOrganName());
				samapply.setCurrentOrgArea(orgSjdw.getOrganCode());
			}
		}
		samapplyDao.update(samapply);
		
		//向业务申请_办理信息中添加一条新数据
		//生成当前日期
		String today=DateUtil.getDay();
		String todayTime=DateUtil.getTime();
		
		//生成新的UUID
		String applyId2 = IdHelp.getUUID32();
		
		//得到传过来的业务申请ID
		String applyId=samapply.getApplyId();
		
		//创建BspInfo
		OrganView org = op.getOrganByOrganId(bspInfo.getCorporationOrganId());
		String orgName=org.getOrganName();
		String orgCode=org.getOrganCode();
		
		//将得到的所有东西存入samapplyHandle中
		SamApplyHandle samapplyHandle = new SamApplyHandle();
		String historyId = applyId2.substring(25, 32);
		samapplyHandle.setHistoryId(today + historyId);
		samapplyHandle.setApplyId(applyId);
		samapplyHandle.setHandleOpinion(samapply.getHandleOpinion());
		samapplyHandle.setHandlePeople(bspInfo.getUserName());
		samapplyHandle.setHandleId(IdHelp.getUUID30());
		samapplyHandle.setHandleOrgName(orgName);
		samapplyHandle.setHandleOrgArea(orgCode);
		samapplyHandle.setHandleOrg(bspInfo.getCorporationOrganId());
		samapplyHandle.setHandleTime(todayTime);
		samapplyHandle.setHandleState(samapply.getHandleResult());
		this.samapplyHandleDao.insert(samapplyHandle);
		
	}
	
	/**
	 * 删除业务
	 * 
	 * @param delIds
	 */
	public void delete(String[] delIds) {
		if (delIds != null && delIds.length > 0) {
			samapplyHandleDao.delete(delIds);
			samapplyDao.delete(delIds);
		}
	}

	/**
	 * 初始化插入页面
	 * 
	 * @param samapply
	 */
	public DataSet initInsertJsp(SamApply samapply){
		return samapplyDao.initInsertJsp(samapply);
	}
	
	/**
	 * 查询上级单位
	 * 
	 * @param 
	 */
	@Trans
	public DataSet querySjdw(){
		return samapplyDao.querySjdw();
	}
	
	/**
	 * 查询平级单位
	 * 
	 * @param 
	 */
	@Trans
	public DataSet queryPjdw(){
		return samapplyDao.queryPjdw();
	}
	
	/**
	 * 查询下级单位
	 * 
	 * @param 
	 */
	@Trans
	public DataSet queryXjdw(){
		return samapplyDao.queryXjdw();
	}
	
	/**
	 * 提交审核
	 * 
	 * @param 
	 */
	@Trans
	public void tjsh(String[] delIds){
		samapplyDao.tjsh(delIds);
	}
	
	/**
	 * 变更
	 * 
	 * @param 
	 */
	@Trans
	public void updatebgSamApply(SamApply samapply)
	{
		samapplyDao.update(samapply);
	}
	
	/**
	 * 获得当天日期往后数几天的方法
	 * 
	 * @param datas
	 */
	public String getDate(int datas) {
		GregorianCalendar calendar = new GregorianCalendar();
		calendar.add(GregorianCalendar.DATE, datas);
		Date date = new Date( calendar.getTime().getTime());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String beginDate = sdf.format(date);
		return beginDate;
	}

	public ISamApplyDao getSamApplyDao() {
		return samapplyDao;
	}

	public void setSamApplyDao(ISamApplyDao samapplyDao) {
		this.samapplyDao = samapplyDao;
	}

	public ISamApplyHandleDao getSamApplyHandleDao() {
		return samapplyHandleDao;
	}

	public void setSamApplyHandleDao(ISamApplyHandleDao samapplyHandleDao) {
		this.samapplyHandleDao = samapplyHandleDao;
	}
	public void hfSave(SamApply samapply)
	{	
		samapply.setVisitPeople(samapply.getAcceptPeople());
		samapply.setVisitTime(samapply.getApplyDate());
		samapply.setReturnVisit("1");
		samapplyDao.update(samapply);
		
	}
	public void ywhf(SamApply samapply,String[] applyId)
	{	
		samapplyDao.ywhf(samapply,applyId);
		
	}
}
