package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.capital.domain.IBptCapitalRetStaDomain;
        
/**
 * @title 农村退役士兵补助标准维护
 * @author  Lin Yangyang
 *
 */
public class BptCapitalRetStaCommand extends BaseAjaxCommand{
	
	private IBptCapitalRetStaDomain retiredStdService = ScaComponentFactory.getService(IBptCapitalRetStaDomain.class,"retStaDomain/retStaDomain");
	
	/**
	 * 保存功能
	 */
	@Trans
	public void save() {
		ParameterSet pset = getParameterSet();
		retiredStdService.save(pset);
	}
	/**
	 * 删除功能
	 */
	@Trans
	public void deleteList(){
		ParameterSet pset = getParameterSet();
		retiredStdService.deleteList(pset);
	}
	/**
	 * 获得最大生效日期起
	 */
	@Trans
	public void getMaxDate(){
		ParameterSet pset = getParameterSet();
		DataSet ds = retiredStdService.getMaxDate(pset);
		if(ds.getCount()>0){
			String startDate =(String)ds.getRecord(0).get("START_DATE");
			this.setReturn("startDate", startDate);
		}
	}
}
