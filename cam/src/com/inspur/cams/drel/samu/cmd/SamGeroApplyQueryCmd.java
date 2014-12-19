package com.inspur.cams.drel.samu.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.samu.domain.ISamGeroApplyDomain;

/**
 * 敬老院业务主表查询cmd
 * @author 
 * @date 2012-10-24
 */
public class SamGeroApplyQueryCmd extends BaseQueryCommand {

	private ISamGeroApplyDomain samGeroApplyDomain = ScaComponentFactory
			.getService(ISamGeroApplyDomain.class, "samGeroApplyDomain/samGeroApplyDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samGeroApplyDomain.query(pset);
	}
	//查询查体名册列表
	public DataSet queryList() {
		ParameterSet pset = getParameterSet();
		return samGeroApplyDomain.queryList(pset);
	}
	//维护名册时，弹出查询明细
	public DataSet queryCheckDetail(){
		ParameterSet pset = getParameterSet();
		return samGeroApplyDomain.queryCheckDetail(pset);
	}
	//零花钱查询名册@tr
	public DataSet queryMoneryList(){
		ParameterSet pset = getParameterSet();
		return samGeroApplyDomain.queryMoneryList(pset);
	}
	//服装查询名册@tr
	public DataSet queryClothList(){
		ParameterSet pset = getParameterSet();
		return samGeroApplyDomain.queryClothList(pset);
	}
	//零花钱查询明细名册@tr
	public DataSet queryMoneyDetail(){
		ParameterSet pset = getParameterSet();
		return samGeroApplyDomain.queryMoneyDetail(pset);
	}
	//服装查询明细名册@tr
	public DataSet queryClothDetail(){
		ParameterSet pset = getParameterSet();
		return samGeroApplyDomain.queryClothDetail(pset);
	}
	//零花钱查询统计@tr
	public DataSet queryPocketList(){
		ParameterSet pset = getParameterSet();
		return samGeroApplyDomain.queryPocketList(pset);
	}
	//服装查询统计@tr
	public DataSet applyClothList(){
		ParameterSet pset = getParameterSet();
		return samGeroApplyDomain.applyClothList(pset);
	}
	//查体查询统计@tr
	public DataSet applyCheckList(){
		ParameterSet pset = getParameterSet();
		return samGeroApplyDomain.applyCheckList(pset);
	}
}