package com.inspur.cams.sorg.online.apply.fee.domain.support;

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
import com.inspur.cams.sorg.base.data.SomMeeting;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.data.SomFee;
import com.inspur.cams.sorg.base.domain.ISomApplyDomain;
import com.inspur.cams.sorg.base.domain.ISomMeetingDomain;
import com.inspur.cams.sorg.base.domain.ISomOrganDomain;
import com.inspur.cams.sorg.online.apply.fee.domain.ISomFeeOnlineDomain;
import com.inspur.cams.sorg.util.ApplyType;

/**
 * 社会组织章程信息domain
 * @author yanliangliang
 * @date 2011-9-21
 */
public class SomFeeOnlineDomain implements ISomFeeOnlineDomain {
	
	@Reference
	private SomFeeDao somFeeDao;

	@Reference
	private ISomMeetingDomain somMeetingDomain;

	@Reference
	private ISomApplyDomain somApplyDomain;
	
	@Reference
	private ISomOrganDomain somOrganDomain;

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
			}
			ds.addRecord(somFee);
		}
		return ds;
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
		somMeetingDomain.update(somMeeting);
		somFeeDao.update(somFee);
	}

	/**
	 * 增加章程核准业务
	 * @param somFee
	 */
	public void insertFeeApply(SomApply somApply, SomFee somFee) {
		if ("S".equals(somApply.getSorgType())) {
			somApply.setApplyType(ApplyType.SOM_GROUP_FEE);
		}  
		SomOrgan somOrgan = somApply.getSomOrgan();
		somApply.setSorgId(somFee.getSorgId());
		somApply.setIfFinish("1");
		somApply.setDataSource("ONLINE");
		somApply.setSorgName(somOrgan.getCnName());
		somApplyDomain.insertOnline(somApply);
		somOrganDomain.insert(somOrgan);
		// 维护章程信息
		insertOnline(somFee);
	}
	
	/**
	 * 更新章程业务
	 * @param somFee
	 */
	public void updateFeeApply(SomApply somApply, SomFee somFee) {
		SomOrgan somOrgan = somApply.getSomOrgan();
		somApply.setSorgName(somOrgan.getCnName());
		somApplyDomain.update(somApply);
		update(somFee);
		somOrganDomain.update(somApply.getSomOrgan());
	}
	
}
