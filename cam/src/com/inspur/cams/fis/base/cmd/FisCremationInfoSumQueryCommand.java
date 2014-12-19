package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.domain.IFisCremationInfoSumDomain;

/**
 * @title:FisCremationInfoSumQueryCommand
 * @description:
 * @author:
 * @since:2012-11-13
 * @version:1.0
*/
public class FisCremationInfoSumQueryCommand extends BaseQueryCommand{

	private IFisCremationInfoSumDomain fisCremationInfoSumDomain = ScaComponentFactory.getService(IFisCremationInfoSumDomain.class, "fisCremationInfoSumDomain/fisCremationInfoSumDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return fisCremationInfoSumDomain.query(pset);
//		ParameterSet pset = getParameterSet();
//		DataSet ds = fisCremationInfoSumDomain.queyAllSum(pset);
//		return ds;
	}
	
	public DataSet queyDeadInfo(){
		ParameterSet pset = getParameterSet();
		DataSet ds = fisCremationInfoSumDomain.queyDeadInfo(pset);
		return ds;
	}
	
	/**
	 * @Description: 查询统计信息
	 * @author xuexzh
	 */
	public DataSet queyAllSum(){
		ParameterSet pset = getParameterSet();
		DataSet ds = fisCremationInfoSumDomain.queyAllSum(pset);
		return ds;
	}
}
