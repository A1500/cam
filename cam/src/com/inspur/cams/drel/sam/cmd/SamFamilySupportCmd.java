package com.inspur.cams.drel.sam.cmd;

import java.math.BigDecimal;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.baseinfo.dao.jdbc.BaseinfoFamilyDao;
import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.baseinfo.domain.IBaseinfoDomain;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.application.city.domain.ISamCityApplyDomain;
import com.inspur.cams.drel.sam.dao.jdbc.SamFamilySupportDao;
import com.inspur.cams.drel.sam.data.SamApplyInfo;
import com.inspur.cams.drel.sam.data.SamFamilySupport;
import com.inspur.cams.drel.sam.domain.ISamApplyInfoDomain;

/**
 * 赡扶抚养义务人员信息Cmd
 */
public class SamFamilySupportCmd extends BaseAjaxCommand {
	SamFamilySupportDao dao = (SamFamilySupportDao) DaoFactory.getDao(SamFamilySupportDao.class);
	// 获取SCA组件
	private IBaseinfoDomain baseinfoDomain = ScaComponentFactory.getService(IBaseinfoDomain.class, "baseinfoDomain/baseinfoDomain");
	// 获取SCA组件
	private ISamApplyInfoDomain samApplyInfoDomain = ScaComponentFactory.getService(ISamApplyInfoDomain.class, "samApplyInfoDomain/samApplyInfoDomain");
	
	/**
	 * 保存
	 */
	@Trans
	public void save(){
		Record record = (Record) getParameter("record");
		String assistanceType=(String)getParameter("assistanceType");
		String applyId=(String)getParameter("applyId");
		String assistanceModeValue = (String) getParameter("assistanceModeValue");
		SamFamilySupport databean=(SamFamilySupport)record.toBean(SamFamilySupport.class);
		String supportId=databean.getSupportId();
		if("".equals(supportId) || supportId == null){//新增
			databean.setSupportId(IdHelp.getUUID32());
			dao.insert(databean);
		}else{//修改
			dao.update(databean);
		}
		if("01".endsWith(assistanceType)){//是城市低保
			baseinfoDomain.updateIncomeByMonth(databean.getFamilyId());
		}else if("02".endsWith(assistanceType)){
			baseinfoDomain.updateIncomeByYear(databean.getFamilyId());
		}
		baseinfoDomain.updatePeopleNum(databean.getFamilyId());
		//查询家庭信息
		BaseinfoFamily baseinfoFamily=baseinfoDomain.getFamily(databean.getFamilyId());
		//更新apply信息
		if( !"".equals(applyId) && applyId != null &&!"03".equals(assistanceType)){
			ParameterSet pset =new ParameterSet();
			pset.setParameter("APPLY_ID", applyId);
			DataSet ds = samApplyInfoDomain.query(pset);
			if(ds.getCount() > 0 ){
				SamApplyInfo samApplyInfo=(SamApplyInfo)ds.getRecord(0).toBean(SamApplyInfo.class);
				samApplyInfo.setAssistancePeopleNum(baseinfoFamily.getAssistancePeopleNum());
				samApplyInfo.setPeopleNum(baseinfoFamily.getPeopleNum());
				if("10".equals(assistanceModeValue)){
					//户月保障金的计算
					BigDecimal assistanceMoney;
					if("01".equals(assistanceType)){
						assistanceMoney=samApplyInfoDomain.getCityAssistanceMoney(baseinfoFamily);
					}else{
						assistanceMoney=samApplyInfoDomain.getCountryAssistanceMoney(baseinfoFamily);
					}
					baseinfoFamily.setAssistanceMoney(assistanceMoney);
					samApplyInfo.setAssistanceMoney(assistanceMoney);
				}
				
				samApplyInfoDomain.update(samApplyInfo);
			}
		}
		setReturn("monthIncome",baseinfoFamily.getMonthIncome());
		setReturn("monthAverageIncome",baseinfoFamily.getMonthAverageIncome());
		setReturn("yearIncome",baseinfoFamily.getYearIncome());
		setReturn("yearAverageIncome",baseinfoFamily.getYearAverageIncome());
		if("10".equals(assistanceModeValue)){
			setReturn("assistanceMoney",baseinfoFamily.getAssistanceMoney());
		}else{
			setReturn("assistanceMoney","null");
		}
	}
	/**
	 * 删除
	 */
	@Trans
	public void delete() {
		Record record = (Record) getParameter("delId");
		String assistanceType=(String)getParameter("assistanceType");
		String applyId=(String)getParameter("applyId");
		String assistanceModeValue = (String) getParameter("assistanceModeValue");
		SamFamilySupport databean=(SamFamilySupport)record.toBean(SamFamilySupport.class);
		
		dao.delete(databean.getSupportId());
		
		if("01".endsWith(assistanceType)){//是城市低保
			baseinfoDomain.updateIncomeByMonth(databean.getFamilyId());
		}else if("02".endsWith(assistanceType)){
			baseinfoDomain.updateIncomeByYear(databean.getFamilyId());
		}
		baseinfoDomain.updatePeopleNum(databean.getFamilyId());
		//查询家庭信息
		BaseinfoFamily baseinfoFamily=baseinfoDomain.getFamily(databean.getFamilyId());
		//更新apply信息
		if( !"".equals(applyId) && applyId != null && !"03".equals(assistanceType)){
			ParameterSet pset =new ParameterSet();
			pset.setParameter("APPLY_ID", applyId);
			DataSet ds = samApplyInfoDomain.query(pset);
			if(ds.getCount() > 0 ){
				SamApplyInfo samApplyInfo=(SamApplyInfo)ds.getRecord(0).toBean(SamApplyInfo.class);
				samApplyInfo.setAssistancePeopleNum(baseinfoFamily.getAssistancePeopleNum());
				samApplyInfo.setPeopleNum(baseinfoFamily.getPeopleNum());
				if("10".equals(assistanceModeValue)){
					//户月保障金的计算
					BigDecimal assistanceMoney;
					if("01".equals(assistanceType)){
						assistanceMoney=samApplyInfoDomain.getCityAssistanceMoney(baseinfoFamily);
					}else{
						assistanceMoney=samApplyInfoDomain.getCountryAssistanceMoney(baseinfoFamily);
					}
					baseinfoFamily.setAssistanceMoney(assistanceMoney);
					samApplyInfo.setAssistanceMoney(assistanceMoney);
				}
				samApplyInfoDomain.update(samApplyInfo);
			}
		}
		setReturn("monthIncome",baseinfoFamily.getMonthIncome());
		setReturn("monthAverageIncome",baseinfoFamily.getMonthAverageIncome());
		setReturn("yearIncome",baseinfoFamily.getYearIncome());
		setReturn("yearAverageIncome",baseinfoFamily.getYearAverageIncome());
		if("10".equals(assistanceModeValue)){
			setReturn("assistanceMoney",baseinfoFamily.getAssistanceMoney());
		}else{
			setReturn("assistanceMoney","null");
		}
	}
}
