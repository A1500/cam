package com.inspur.cams.drel.mbalance.cmd;

import java.util.ArrayList;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.diccity.data.DicCity;
import com.inspur.cams.drel.mbalance.domain.ISamMedicalConConfigDomain;

/**
 * @title:SamMedicalConConfigQueryCommand
 * @description:一站结算_医保系统连接配置查询cmd
 * @author:路国隋
 * @since:2011-09-27
 * @version:1.0
*/
public class SamMedicalConConfigQueryCmd extends BaseQueryCommand{
	private ISamMedicalConConfigDomain samMedicalConConfigDomain=ScaComponentFactory.getService(ISamMedicalConConfigDomain.class, "samMedicalConConfigDomain/samMedicalConConfigDomain");

	public DataSet execute() {
		ParameterSet paramSet = getParameterSet();
		DataSet samMBalance=samMedicalConConfigDomain.query(paramSet);
		return samMBalance;
	}
}
