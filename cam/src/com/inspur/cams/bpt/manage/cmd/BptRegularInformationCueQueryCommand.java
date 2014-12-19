package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.bpt.base.domain.IBptRegularInformationCueDomain;

/**
 * @title:BptRegularInformationCueQueryCommand
 * @description:定期提示
 * @author:
 * @since:2011-06-03
 * @version:1.0
*/
public class BptRegularInformationCueQueryCommand extends BaseQueryCommand{
	
	IBptRegularInformationCueDomain service = ScaComponentFactory.getService(IBptRegularInformationCueDomain.class,
	"bptRegularInformationCueDomain/bptRegularInformationCueDomain");
	
	public DataSet execute(){
		ParameterSet pset = getParameterSet();
		return service.queryRegularInforCue(pset);
	}
}
