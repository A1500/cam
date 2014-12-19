package com.inspur.cams.drel.esurey.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.esurey.domain.ISamEsureyHouseDomain;
/**
 * @title:SamEsureyHouseQueryCmd
 * @description:房管查询Command
 * @author:luguosui
 * @since:2011-06-30
 * @version:1.0
*/
public class SamEsureyHouseQueryCmd extends BaseQueryCommand {
	ISamEsureyHouseDomain samEsureyHouseDomain = ScaComponentFactory.getService(ISamEsureyHouseDomain.class,
	"SamEsureyHouseDomain/SamEsureyHouseDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samEsureyHouseDomain.query(pset);
	}
	public DataSet queryExtHouse() {
		
		ParameterSet pset = getParameterSet();
		return samEsureyHouseDomain.queryExtHouse(pset);
	}
}
