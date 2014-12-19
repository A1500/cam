package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.data.DisabilityIdentification;
import com.inspur.cams.bpt.base.domain.IDisabilityIdentificationDomain;

/**
 * 鉴定介绍信添加
 */
public class DisabilityIdentificationCommand extends BaseAjaxCommand{
	
	/**
	 * 获得伤残鉴定介绍信服务接口
	 */
	private IDisabilityIdentificationDomain disabilityIdentificationService = ScaComponentFactory.getService(IDisabilityIdentificationDomain.class,
	"disabilityIdentificationDomain/disabilityIdentificationDomain");
	
	/**
	 * 添加鉴定介绍信添加
	 */
	@Trans
	public void update(){
		Record record = (Record) getParameter("record");
		DisabilityIdentification dataBean = (DisabilityIdentification)record.toBean(DisabilityIdentification.class);
		disabilityIdentificationService.update(dataBean);
	}
	
	/**
	 * 获得编号流水号
	 */
	public void getId(){
		ParameterSet pset = getParameterSet();
		String idPre = (String)pset.getParameter("idPre");
		String idFix = disabilityIdentificationService.getMaxNumber(idPre);
		String id = idPre+idFix;
		this.setReturn("id", id);
		
		pset.remove("idPre");
		DataSet identiDataSet = disabilityIdentificationService.query(pset);
		Record identiRecord = identiDataSet.getRecord(0);
		
		if(identiRecord.get("numbering") != null){
			String numbering = identiRecord.get("numbering")+"";
			setReturn("numbering", numbering);
		}
	}
	/**
	 * 是否已经保存
	 */
	public void haveSave(){
		ParameterSet pset = getParameterSet();
		DataSet identiDataSet = disabilityIdentificationService.query(pset);
		if(identiDataSet.getCount()>0){
			String identificationUnit = (String)identiDataSet.getRecord(0).get("identificationUnit");
			
			if(identificationUnit!=null&&!"".equals(identificationUnit)){
				setReturn("flag", "false");
			}else {
				setReturn("flag", "true");
			}
		}
	}
}