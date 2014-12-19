package com.inspur.cams.fis.base.cmd;

import java.util.List;
import java.util.ArrayList;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.fis.base.data.FisServicesDutyInfo;
import com.inspur.cams.fis.base.data.FisServicesPeopleInfo;
import com.inspur.cams.fis.base.domain.IFisServicesDutyInfoDomain;
import com.inspur.cams.fis.base.domain.IFisServicesPeopleInfoDomain;

/**
 * 殡葬服务机构工作人员信息表cmd
 * @author 
 * @date Wed May 02 09:01:05 GMT+08:00 2012
 */
public class FisServicesPeopleInfoCmd extends BaseAjaxCommand {

	private IFisServicesPeopleInfoDomain fisServicesPeopleInfoDomain = ScaComponentFactory
			.getService(IFisServicesPeopleInfoDomain.class, "fisServicesPeopleInfoDomain/fisServicesPeopleInfoDomain");

	private IFisServicesDutyInfoDomain fisServicesDutyInfoDomain = ScaComponentFactory
			.getService(IFisServicesDutyInfoDomain.class, "fisServicesDutyInfoDomain/fisServicesDutyInfoDomain");

	@Trans
	public void insert() {
		Record recordPeople = (Record) getParameter("recordPeople");
		Record[] recordDuty = (Record[]) getParameter("recordDuty");
		
		if(recordDuty == null) {
			recordDuty = new Record[0];
		}
		
		// 人员信息
		FisServicesPeopleInfo peopleBean = (FisServicesPeopleInfo) recordPeople.toBean(FisServicesPeopleInfo.class);

		peopleBean.setPeopleId(IdHelp.getUUID32());
		peopleBean.setCreatePeople(BspUtil.getEmpOrgan().getOrganId());
		peopleBean.setCreatePeopleName(BspUtil.getEmpOrgan().getOrganName());
		peopleBean.setCreateTime(DateUtil.getTime());
		fisServicesPeopleInfoDomain.insert(peopleBean);
		
		// 岗位信息
		for (int i = 0; i < recordDuty.length; i++) {
			FisServicesDutyInfo dutyBean = (FisServicesDutyInfo) recordDuty[i].toBean(FisServicesDutyInfo.class);
			
			dutyBean.setDutyId(IdHelp.getUUID32());
			dutyBean.setPeopleId(peopleBean.getPeopleId());
			dutyBean.setCreateOrgan(peopleBean.getCreateOrgan());
			dutyBean.setCreateOrganName(peopleBean.getCreateOrganName());
			dutyBean.setCreatePeople(peopleBean.getCreatePeople());
			dutyBean.setCreatePeopleName(peopleBean.getCreatePeopleName());
			dutyBean.setCreateTime(peopleBean.getCreateTime());
			fisServicesDutyInfoDomain.insert(dutyBean);
		}
	}
	
	@Trans
	public void update() {
		
		Record recordPeople = (Record) getParameter("recordPeople");
		Record[] recordDuty = (Record[]) getParameter("recordDuty");
		if(recordDuty == null) {
			recordDuty = new Record[0];
		}
		
		// 人员信息
		FisServicesPeopleInfo peopleBean = (FisServicesPeopleInfo) recordPeople.toBean(FisServicesPeopleInfo.class);
		
		List<FisServicesPeopleInfo> customList=new ArrayList<FisServicesPeopleInfo>();
		customList.add(peopleBean);
		fisServicesPeopleInfoDomain.update(peopleBean);

		// 岗位信息
		for (int i = 0; i < recordDuty.length; i++) {
			FisServicesDutyInfo dutyBean = (FisServicesDutyInfo) recordDuty[i].toBean(FisServicesDutyInfo.class);
			dutyBean.setPeopleId(peopleBean.getPeopleId());
			fisServicesDutyInfoDomain.update(dutyBean);
		}
	}
	
	// 删除
	public void delete() {
		String peopleId = (String) getParameter("peopleId");
		fisServicesPeopleInfoDomain.delete(peopleId);
	}
	
}