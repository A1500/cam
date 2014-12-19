package com.inspur.cams.dis.base.cmd;

import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.dis.base.data.DisFundsYearBudget;
import com.inspur.cams.dis.base.domain.IDisFundsYearBudgetDomain;

/**
 * 救灾资金年度预算表cmd
 * @author 
 * @date 2012-11-15
 */
public class DisFundsYearBudgetCmd extends BaseAjaxCommand {

	private IDisFundsYearBudgetDomain disFundsYearBudgetDomain = ScaComponentFactory
			.getService(IDisFundsYearBudgetDomain.class, "disFundsYearBudgetDomain/disFundsYearBudgetDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		DisFundsYearBudget disFundsYearBudget = (DisFundsYearBudget) record.toBean(DisFundsYearBudget.class);
		disFundsYearBudget.setFillOrganCode(BspUtil.getOrganCode());
		disFundsYearBudget.setFillOrganName(BspUtil.getOrganName());
		disFundsYearBudget.setFillPeopleName(GetBspInfo.getBspInfo().getUserName());
		disFundsYearBudget.setFillTime(DateUtil.getTime());
		disFundsYearBudgetDomain.insert(disFundsYearBudget);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		DisFundsYearBudget disFundsYearBudget = (DisFundsYearBudget) record.toBean(DisFundsYearBudget.class);
		disFundsYearBudget.setFillOrganCode(BspUtil.getOrganCode());
		disFundsYearBudget.setFillOrganName(BspUtil.getOrganName());
		disFundsYearBudget.setFillPeopleName(GetBspInfo.getBspInfo().getUserName());
		disFundsYearBudget.setFillTime(DateUtil.getTime());
		disFundsYearBudgetDomain.update(disFundsYearBudget);
	}
	
	// 删除
	public void delete() {
		String id = (String) getParameter("id");
		disFundsYearBudgetDomain.delete(id);
	}
	
	/**
	 * 查询是否存在年度disYear，若有返回true，没有返回false
	 * @param budgetType
	 * @return
	 */
	public void queryDisYear(){
		Record record = (Record) getParameter("record");
		DisFundsYearBudget disFundsYearBudget = (DisFundsYearBudget) record.toBean(DisFundsYearBudget.class);
		DataSet ds = disFundsYearBudgetDomain.queryDisYear(disFundsYearBudget);
		if(ds.getCount()>0){//存在为true
			this.setReturn("hasDisYear", "true");
		}else{
			this.setReturn("hasDisYear", "false");
		}
	}
	
	/**
	 * 查询一年预算金额总和
	 */
	public void queryYearMoneyReady(){
		ParameterSet pset = getParameterSet();
		String sumYearMoneyReady = disFundsYearBudgetDomain.queryYearMoneyReady(pset);
		this.setReturn("sumYearMoneyReady", sumYearMoneyReady);
	}
}