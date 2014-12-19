package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.capital.domain.IBptCapitalMarStaDomain;
        
/**
 * @title 烈士子女补助标准维护
 * @author Lin Yangyang
 *
 */
public class BptCapitalMarStaCommand extends BaseAjaxCommand{
	
	private IBptCapitalMarStaDomain martyrStdService = ScaComponentFactory.getService(IBptCapitalMarStaDomain.class,"marStaDomain/marStaDomain");
	
	/**
	 * 保存功能
	 */
	@Trans
	public void save() {
		ParameterSet pset = getParameterSet();
		martyrStdService.save(pset);
	}
	/**
	 * 删除功能
	 */
	@Trans
	public void deleteList(){
		ParameterSet pset = getParameterSet();
		martyrStdService.deleteList(pset);
	}
	/**
	 * 获得最大生效日期起
	 */
	@Trans
	public void getMaxDate(){
		ParameterSet pset = getParameterSet();
		DataSet ds = martyrStdService.getMaxDate(pset);
		if(ds.getCount()>0){
			String startDate =(String)ds.getRecord(0).get("START_DATE");
			this.setReturn("startDate", startDate);
		}
	}
}
