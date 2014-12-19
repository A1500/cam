package com.inspur.cams.drel.application.cityLow.cmd;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.baseinfo.domain.IBaseinfoDomain;
import com.inspur.cams.drel.application.cityLow.domain.ISamLowApplyInfoDomain;
import com.inspur.cams.drel.application.cityLow.domain.ISamLowPeopleIncomeDomain;
import com.inspur.cams.drel.application.cityLow.domain.ISamLowPeoplePropertyDomain;

/**
 * 人员信息查询Cmd
 * 
 * @author wang_chen
 * 
 */
public class SamCityLowConfirmQueryCmd extends BaseQueryCommand {
	IBaseinfoDomain baseinfoDomain = ScaComponentFactory.getService(
			IBaseinfoDomain.class, "baseinfoDomain/baseinfoDomain");
	private ISamLowApplyInfoDomain applyInfservice = ScaComponentFactory.getService(ISamLowApplyInfoDomain.class, "samLowApplyInfoDomain/samLowApplyInfoDomain");
	private ISamLowPeopleIncomeDomain incomeService = ScaComponentFactory.getService(ISamLowPeopleIncomeDomain.class, "samLowPeopleIncomeDomain/samLowPeopleIncomeDomain");
	private ISamLowPeoplePropertyDomain propertyService = ScaComponentFactory.getService(ISamLowPeoplePropertyDomain.class, "samLowPeoplePropertyDomain/samLowPeoplePropertyDomain");
	
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return baseinfoDomain.queryPeople(pset);
	}
	public DataSet queryPeopleAll(){
		ParameterSet pset = getParameterSet();
		return incomeService.queryByID(pset);
	}
	public DataSet lowQuery(){
		ParameterSet pset = getParameterSet();
		return incomeService.lowQueryByPeople(pset);
	}
	public DataSet lowFamilyWealthCount(){
		ParameterSet pset = getParameterSet();
		DataSet ds = incomeService.lowFamilyWealthCount(pset);
		for(int i =0;i<ds. getCount();i++){
			Record r = ds.getRecord(i);
			BigDecimal num = (BigDecimal)r.get("FAMILYCOUNT");//无需验证非空，因为都有数据
			BigDecimal avgIncome = (BigDecimal)r.get("FAMINCOME");
			BigDecimal avgpro = (BigDecimal)r.get("FAMILYPROPERTY");
			BigDecimal avgIncomeBd = avgIncome.divide(num, BigDecimal.ROUND_CEILING);
			BigDecimal avgproBd = avgpro.divide(num, BigDecimal.ROUND_CEILING);
			r.set("FAMINCOME", avgIncomeBd);
			r.set("FAMILYPROPERTY", avgproBd);
			
		}
		return ds;
		 
	}
	public DataSet lowFamilyNoCount(){
		ParameterSet pset = getParameterSet();
		
		return incomeService.lowFamilyNoCount(pset);
	}
	public DataSet lowFamilyCount(){
		ParameterSet pset = getParameterSet();
		
		DataSet ds = incomeService.lowFamilyCount(pset);
		for(int i =0;i<ds. getCount();i++){
			Record r = ds.getRecord(i);
			
			BigDecimal num = (BigDecimal)r.get("NUM");//无需验证非空，因为都有数据
			BigDecimal avgIncome = (BigDecimal)r.get("TOTALINC");
			BigDecimal avgpro = (BigDecimal)r.get("TOTALPRO");
			BigDecimal avgIncomeBd =BigDecimal.ZERO;
			BigDecimal avgproBd =BigDecimal.ZERO;
			
			if(num.compareTo(BigDecimal.ZERO)>0){
				avgIncomeBd= avgIncome.divide(num, BigDecimal.ROUND_CEILING);
				avgproBd = avgpro.divide(num, BigDecimal.ROUND_CEILING);
			}			
			r.set("TOTALINC", avgIncomeBd);
			r.set("TOTALPRO", avgproBd);			
		}
		return ds;
	}
	public DataSet lowFamilyAvgIncCount(){
		ParameterSet pset = getParameterSet();
		
		DataSet ds = incomeService.lowFamilyAvgIncCount(pset);
		
		return ds;
	}
	public DataSet lowFamilyAvgAreaCount(){
		ParameterSet pset = getParameterSet();
		
		DataSet ds = incomeService.lowFamilyAvgAreaCount(pset);
		
		return ds;
	}

	
}
