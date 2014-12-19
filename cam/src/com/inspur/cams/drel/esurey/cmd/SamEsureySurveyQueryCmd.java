package com.inspur.cams.drel.esurey.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.esurey.domain.ISamEsureySurveyDomain;
/**
 * @title:SamEsureySurveyQueryCommand
 * @description:经济核对_核对流水Command
 * @author:luguosui
 * @since:2011-06-29
 * @version:1.0
*/
public class SamEsureySurveyQueryCmd extends BaseQueryCommand{
	ISamEsureySurveyDomain samEsureySurveyDomain = ScaComponentFactory.getService(ISamEsureySurveyDomain.class,
	"SamEsureySurveyDomain/SamEsureySurveyDomain");
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samEsureySurveyDomain.query(pset);
	}
	/**
	 * 查询家庭核对流水
	 * @return
	 */
	public DataSet queryForEsureyList(){
		ParameterSet pset = getParameterSet();
		return samEsureySurveyDomain.queryForEsureyList(pset);
	}
}
