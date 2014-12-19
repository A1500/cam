package com.inspur.cams.drel.esurey.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.esurey.domain.ISamEsureyCarDomain;
/**
 * @title:SamEsureyCarQueryCmd
 * @description:公安查询Command
 * @author:luguosui
 * @since:2011-06-30
 * @version:1.0
*/
public class SamEsureyCarQueryCmd extends BaseQueryCommand {
	ISamEsureyCarDomain samEsureyCarDomain = ScaComponentFactory.getService(ISamEsureyCarDomain.class,
	"SamEsureyCarDomain/SamEsureyCarDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samEsureyCarDomain.query(pset);
	}
	public DataSet queryExtCar() {
		ParameterSet pset = getParameterSet();
		return samEsureyCarDomain.queryExtCar(pset);
	}
}
