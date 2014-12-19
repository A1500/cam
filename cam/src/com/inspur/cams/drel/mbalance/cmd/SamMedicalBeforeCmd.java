package com.inspur.cams.drel.mbalance.cmd;

import java.util.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.mbalance.data.SamMedicalBefore;
import com.inspur.cams.drel.mbalance.domain.ISamMedicalBeforeDomain;
/**
 * @title:SamMedicalBeforeCommand
 * @description:医前救助command
 * @author:luguosui
 * @since:2011-06-25
 * @version:1.0
*/
public class SamMedicalBeforeCmd extends BaseAjaxCommand{
	private ISamMedicalBeforeDomain samMedicalBeforeDaoDomain=ScaComponentFactory.getService(ISamMedicalBeforeDomain.class, "samMedicalBeforeDomain/samMedicalBeforeDomain");

	public void insert() {
		Record[] record = (Record[]) getParameter("records");
		SamMedicalBefore dataBean=(SamMedicalBefore)record[0].toBean(SamMedicalBefore.class);
		dataBean.setId(IdHelp.getUUID30());
		dataBean.setIdCardType("1");
		dataBean.setAssitanceOrg(BspUtil.getCorpOrgan().getOrganName());
		dataBean.setRegId(BspUtil.getEmpOrgan().getOrganId());
		dataBean.setRegPeople(BspUtil.getEmpOrgan().getOrganName());
		dataBean.setRegTime(DateUtil.getTime());
		samMedicalBeforeDaoDomain.insert(dataBean);
	}

	public void update() {
		Record[] record = (Record[]) getParameter("records");
		SamMedicalBefore dataBean=(SamMedicalBefore)record[0].toBean(SamMedicalBefore.class);

		dataBean.setAssitanceOrg(BspUtil.getCorpOrgan().getOrganName());
		dataBean.setModId(BspUtil.getEmpOrgan().getOrganId());
		dataBean.setModPeople(BspUtil.getEmpOrgan().getOrganName());
		dataBean.setModTime(DateUtil.getTime());
		samMedicalBeforeDaoDomain.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		samMedicalBeforeDaoDomain.batchDelete(delIds);
	}
	public void save() {
		Record[] records = (Record[]) getParameter("records");
		List<SamMedicalBefore> list = new ArrayList<SamMedicalBefore>();
		for (int i = 0; i < records.length; i++) {
			SamMedicalBefore dataBean = (SamMedicalBefore) records[i].toBean(SamMedicalBefore.class);
			list.add(dataBean);
		}

		samMedicalBeforeDaoDomain.save(list);
	}
}
