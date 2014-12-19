package com.inspur.cams.drel.sam.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.drel.sam.dao.jdbc.SamFamilyTreatmentDao;
import com.inspur.cams.drel.sam.domain.ISamFamilyTreatmentDomain;

/**
 * @title:家庭待遇信息Command
 * @description:
 * @author: yanll
 * @since:2012-05-03
 * @version:1.0
*/
public class SamFamilyTreatmentQueryCmd extends BaseQueryCommand {
	private ISamFamilyTreatmentDomain samFamilyTreatmentDomain = ScaComponentFactory.getService(ISamFamilyTreatmentDomain.class, "samFamilyTreatmentDomain/samFamilyTreatmentDomain");
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samFamilyTreatmentDomain.query(pset);
	}
	
	public DataSet queryAdjustList() {
		ParameterSet pset = getParameterSet();
		
		String domicileCode=(String)pset.getParameter("domicileCode");
		if(domicileCode.endsWith("0000000000")){
			pset.setParameter("domicileCode",domicileCode.subSequence(0, 2)+"%");
		} else if (domicileCode.endsWith("00000000")){
			pset.setParameter("domicileCode",domicileCode.subSequence(0, 4)+"%");
		} else if (domicileCode.endsWith("000000")){
			pset.setParameter("domicileCode",domicileCode.subSequence(0, 6)+"%");
		} else if (domicileCode.endsWith("000")){
			pset.setParameter("domicileCode",domicileCode.subSequence(0, 9)+"%");
		}
		pset.setParameter("queryDate", DateUtil.getMonth());
		return samFamilyTreatmentDomain.queryAdjustList(pset);
	}
}
