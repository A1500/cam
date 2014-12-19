package com.inspur.cams.fis.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import com.inspur.cams.fis.base.data.FisCemeteryOrgan;

/**
 * @Path com.inspur.cams.fis.base.dao.IFisCemeteryOrganDao
 * @Description: TODO 殡葬业务公墓信息表Dao的接口
 * @author muqi
 * @date 2012-04-09
 */
public interface IFisCemeteryOrganDao extends BaseCURD<FisCemeteryOrgan> {

	DataSet queryForExport(ParameterSet pset);

}
