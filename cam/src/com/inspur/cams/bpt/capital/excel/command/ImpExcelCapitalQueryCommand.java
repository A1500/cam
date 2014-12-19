package com.inspur.cams.bpt.capital.excel.command;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.bpt.capital.excel.domain.IImpExcelCapitalDomain;
/**
 * 优抚资金发放excel导入查询command
 * @author zhanghui
 *
 */
public class ImpExcelCapitalQueryCommand extends BaseQueryCommand{
	
	private IImpExcelCapitalDomain impExcelCapitalService = ScaComponentFactory.getService(IImpExcelCapitalDomain.class,
	"ImpExcepCapitalDomain/ImpExcepCapitalDomain");
	
	/**
	 * 查询伤残验证信息
	 * @return
	 */
	public DataSet queryDisabilityMark() {
		ParameterSet pset = getParameterSet();
		return impExcelCapitalService.queryDisabilityMark(pset);
	}
	
	
	
}
