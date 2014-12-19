package com.inspur.cams.drel.mbalance.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.mbalance.dao.jdbc.SamMedicalConConfigDao;
import com.inspur.cams.drel.mbalance.data.SamMedicalConConfig;
import com.inspur.cams.drel.mbalance.domain.ISamMedicalConConfigDomain;
import com.inspur.cams.drel.mbalance.domain.ISamMedicalDetailExpenseDomain;

/**
 * @title:SamMedicalConConfigCommand
 * @description:一站结算_医保系统连接配置cmd
 * @author:路国隋
 * @since:2011-09-27
 * @version:1.0
*/
public class SamMedicalConConfigCmd extends BaseAjaxCommand{
	private ISamMedicalConConfigDomain samMedicalConConfigDomain=ScaComponentFactory.getService(ISamMedicalConConfigDomain.class, "samMedicalConConfigDomain/samMedicalConConfigDomain");


	public void insert() {
		Record record = (Record) getParameter("record");
		SamMedicalConConfig dataBean=(SamMedicalConConfig)record.toBean(SamMedicalConConfig.class);
		samMedicalConConfigDomain.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SamMedicalConConfig dataBean=(SamMedicalConConfig)record.toBean(SamMedicalConConfig.class);
		samMedicalConConfigDomain.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		samMedicalConConfigDomain.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SamMedicalConConfig> list = new ArrayList<SamMedicalConConfig>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SamMedicalConConfig dataBean = (SamMedicalConConfig) records[i].toBean(SamMedicalConConfig.class);
			list.add(dataBean);
		}

		samMedicalConConfigDomain.save(list);
	}
}
