package com.inspur.cams.drel.sam.cmd;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.drel.sam.domain.ISamFamilyTreatmentDomain;

/**
 * @title:家庭待遇信息Command
 * @description:
 * @author: yanll
 * @since:2012-05-03
 * @version:1.0
*/
public class SamFamilyTreatmentCmd extends BaseQueryCommand {
	private ISamFamilyTreatmentDomain samFamilyTreatmentDomain = ScaComponentFactory.getService(ISamFamilyTreatmentDomain.class, "samFamilyTreatmentDomain/samFamilyTreatmentDomain");
	/**
	 * 调整保障金
	 */
	public void updateAssistanceMoney() {
		ParameterSet pset = getParameterSet();
		samFamilyTreatmentDomain.updateAssistanceMoney(pset);
	}	
	/**
	 * 调整所有保障金
	 * @param pset
	 */
	public void updateAllAssistanceMoney(){
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
		samFamilyTreatmentDomain.updateAllAssistanceMoney(pset);
	}
}
