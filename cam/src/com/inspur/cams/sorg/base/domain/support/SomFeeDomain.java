package com.inspur.cams.sorg.base.domain.support;

import org.loushang.bsp.share.organization.bean.OrganView;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.StrUtil;
import com.inspur.cams.sorg.base.dao.jdbc.SomFeeDao;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomElectronic;
import com.inspur.cams.sorg.base.data.SomFee;
import com.inspur.cams.sorg.base.data.SomMeeting;
import com.inspur.cams.sorg.base.domain.ISomApplyDomain;
import com.inspur.cams.sorg.base.domain.ISomElectronicDomain;
import com.inspur.cams.sorg.base.domain.ISomFeeDomain;
import com.inspur.cams.sorg.base.domain.ISomMeetingDomain;
import com.inspur.cams.sorg.util.ApplyType;

/**
 * 社会组织会费标准信息domain
 * @author yanliangliang
 * @date 2011-9-21
 */
public class SomFeeDomain implements ISomFeeDomain {
	
	@Reference
	private SomFeeDao somFeeDao;
	
	@Reference
	private ISomMeetingDomain somMeetingDomain;
	
	@Reference
	private ISomApplyDomain somApplyDomain;
	
	@Reference
	private ISomElectronicDomain somElectronicDomain;

	public DataSet query(ParameterSet pset) {
		return somFeeDao.query(pset);
	}

	public DataSet queryFee(ParameterSet pset) {
		DataSet ds=new DataSet();
		DataSet somFeeDataSet = somFeeDao.query(pset);
		for (int i = 0; i < somFeeDataSet.getCount(); i++) {
			SomFee somFee = (SomFee) somFeeDataSet.getRecord(i).toBean(SomFee.class);
			SomMeeting somMeeting = somMeetingDomain.get(somFee.getMeetingId());
			if(somMeeting!=null){
				somFee.setMeetingName(somMeeting.getMeetingName());
				somFee.setMeetingPlace(somMeeting.getMeetingPlace());
				somFee.setMeetingDate(somMeeting.getMeetingDate());
				somFee.setLinkPeople(somMeeting.getLinkPeople());
				somFee.setLinkPhone(somMeeting.getLinkPhone());
				//如果是新的数据的话，即已经有会议和章程的关联关系，就直接取会议信息中的相关人数
				if(StrUtil.n2b(somMeeting.getIfOld()).equals("0")){
					somFee.setShouldNum(somMeeting.getShouldNum());
					somFee.setRealNum(somMeeting.getRealNum());
					somFee.setPassNum(somMeeting.getPassNum());
					somFee.setNopassNum(somMeeting.getNopassNum());
					somFee.setGiveupNum(somMeeting.getGiveupNum());
				}
			}
			ds.addRecord(somFee);
		}
		return ds;
	}

	public void insert(SomFee somFee) {
		OrganView corpOrgan = BspUtil.getCorpOrgan();
		OrganView empOrgan = BspUtil.getEmpOrgan();
		String time = DateUtil.getTime();
		// 保存会议信息
		SomMeeting somMeeting = new SomMeeting();
		somMeeting.setMeetingId(IdHelp.getUUID32());
		somMeeting.setSorgId(somFee.getSorgId());
		somMeeting.setMeetingName(somFee.getMeetingName());
		somMeeting.setMeetingPlace(somFee.getMeetingPlace());
		somMeeting.setMeetingDate(somFee.getMeetingDate());
		somMeeting.setLinkPeople(somFee.getLinkPeople());
		somMeeting.setLinkPhone(somFee.getLinkPhone());
		somMeeting.setMorgName(corpOrgan.getOrganName());
		somMeeting.setMorgArea(corpOrgan.getOrganCode());
		somMeeting.setCreatePeople(empOrgan.getOrganName());
		somMeeting.setCreateTime(time);
		somMeetingDomain.insert(somMeeting);
		// 保存会费信息
		somFee.setFeeId(IdHelp.getUUID32());
		somFee.setMeetingId(somMeeting.getMeetingId());
		somFee.setMorgName(corpOrgan.getOrganName());
		somFee.setMorgArea(corpOrgan.getOrganCode());
		somFee.setCreatePeople(empOrgan.getOrganName());
		somFee.setCreateTime(time);
		somFeeDao.insert(somFee);
		
	}
	/**
	 * meetingid前台提供
	 */
	public void insertWithOutMeetingInfo(SomFee somFee) {
		OrganView corpOrgan = BspUtil.getCorpOrgan();
		OrganView empOrgan = BspUtil.getEmpOrgan();
		String time = DateUtil.getTime();
		// 保存会费信息
		somFee.setFeeId(IdHelp.getUUID32());
		somFee.setMorgName(corpOrgan.getOrganName());
		somFee.setMorgArea(corpOrgan.getOrganCode());
		somFee.setCreatePeople(empOrgan.getOrganName());
		somFee.setCreateTime(time);
		somFeeDao.insert(somFee);
	}
	
	/**
	 * 会费备案中调用，添加一条apply，不插入新的meeting信息
	 */
	public void insertFeeAddApply(SomFee somFee) {
		OrganView corpOrgan = BspUtil.getCorpOrgan();
		OrganView empOrgan = BspUtil.getEmpOrgan();
		String time = DateUtil.getTime();
		// 保存会议信息
		SomMeeting somMeeting = somMeetingDomain.get(somFee.getMeetingId());
		somMeeting.setMeetingPlace(somFee.getMeetingPlace());
		somMeeting.setShouldNum(somFee.getShouldNum());
		somMeeting.setRealNum(somFee.getRealNum());
		somMeeting.setPassNum(somFee.getPassNum());
		somMeeting.setNopassNum(somFee.getNopassNum());
		somMeeting.setGiveupNum(somFee.getGiveupNum());
		somMeeting.setLinkPeople(somFee.getLinkPeople());
		somMeeting.setLinkPhone(somFee.getLinkPhone());
		somMeetingDomain.update(somMeeting);
		
		// 保存会费信息
		somFee.setFeeId(IdHelp.getUUID32());
		somFee.setMeetingId(somMeeting.getMeetingId());
		somFee.setMorgName(corpOrgan.getOrganName());
		somFee.setMorgArea(corpOrgan.getOrganCode());
		somFee.setCreatePeople(empOrgan.getOrganName());
		somFee.setCreateTime(time);
		somFeeDao.insert(somFee);
		
		if(!somFee.getRegStatus().equals("3")){
			SomApply somApply = new SomApply();
			somApply.setSorgId(somFee.getSorgId());
			somApply.setApplyType(ApplyType.SOM_GROUP_FEE);
			somApply.setTaskCode(somFee.getTaskCode());
			//目前只有社团的有该备案
			somApply.setSorgType("S");
			somApply.setIfFinish("1");
			somApply.setAcceptArea(BspUtil.getCorpOrgan().getOrganCode());
			somApply.setAuditTime(DateUtil.getTime());
			somApplyDomain.insert(somApply);
		}
	}
	
	public void insertOnline(SomFee somFee) {
		String time = DateUtil.getTime();
		// 保存会议信息
		SomMeeting somMeeting = new SomMeeting();
		somMeeting.setMeetingId(IdHelp.getUUID32());
		somMeeting.setSorgId(somFee.getSorgId());
		somMeeting.setMeetingName(somFee.getMeetingName());
		somMeeting.setMeetingPlace(somFee.getMeetingPlace());
		somMeeting.setMeetingDate(somFee.getMeetingDate());
		somMeeting.setLinkPeople(somFee.getLinkPeople());
		somMeeting.setLinkPhone(somFee.getLinkPhone());
		somMeeting.setCreateTime(time);
		somMeetingDomain.insert(somMeeting);
		
		// 保存会费信息
		somFee.setFeeId(IdHelp.getUUID32());
		somFee.setMeetingId(somMeeting.getMeetingId());
		somFee.setCreateTime(time);
		somFeeDao.insert(somFee);
	}

	public void update(SomFee somFee) {
		SomMeeting somMeeting = somMeetingDomain.get(somFee.getMeetingId());
		somMeeting.setMeetingName(somFee.getMeetingName());
		somMeeting.setMeetingPlace(somFee.getMeetingPlace());
		somMeeting.setMeetingDate(somFee.getMeetingDate());
		somMeeting.setLinkPeople(somFee.getLinkPeople());
		somMeeting.setLinkPhone(somFee.getLinkPhone());
		//如果是新的数据的话，即已经有会议和章程的关联关系，就直接更新会议信息中的相关人数
		if(StrUtil.n2b(somMeeting.getIfOld()).equals("0")){
			somMeeting.setShouldNum(somFee.getShouldNum());
			somMeeting.setRealNum(somFee.getRealNum());
			somMeeting.setPassNum(somFee.getPassNum());
			somMeeting.setNopassNum(somFee.getNopassNum());
			somMeeting.setGiveupNum(somFee.getGiveupNum());
		}
		somMeetingDomain.update(somMeeting);
		somFeeDao.update(somFee);
	}
	
	public void del(String taskCode){
		somFeeDao.del(taskCode);
	}

	public void insertPre(SomFee somFee,SomApply somApply) {
		String areaCode = BspUtil.getCorpOrgan().getOrganCode();
		if ("S".equals(somApply.getSorgType())) {
			somApply.setApplyType(ApplyType.SOM_GROUP_FEE);
		}
		somApply.setSorgId(somFee.getSorgId());
		somApply.setIfFinish("1");
		somApply.setDataSource("ONLINE");
		somApply.setAcceptArea(areaCode);
		somApplyDomain.insert(somApply);
		// 
		ParameterSet pset = new ParameterSet();
		pset.setParameter("TASK_CODE", somApply.getTaskCode());
		DataSet ds = somElectronicDomain.queryElectronicOnly(pset);
		for(int i = 0;i<ds.getCount();i++){
			SomElectronic bean = (SomElectronic) ds.getRecord(i).toBean(SomElectronic.class);
			bean.setSorgId(somApply.getSorgId());
			somElectronicDomain.update(bean);
		}
		insert(somFee);
	}

}
