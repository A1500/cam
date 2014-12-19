package com.inspur.cams.prs.prssoldiersplacement.dao;

import java.sql.Types;
import com.inspur.cams.prs.util.PrsSQL;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;

/**
 * @title:PrsSoldiersPlacementDao
 * @description:
 * @author:
 * @since:2011-08-15
 * @version:1.0
*/
 public class PrsSoldiersPlacementDao extends EntityDao<PrsSoldiersPlacement> implements IPrsSoldiersPlacementDao{

 	public PrsSoldiersPlacementDao() throws Exception {
	}

  	@SuppressWarnings("unchecked")
	@Override
	public Class getEntityClass() {
		return PrsSoldiersPlacement.class;
	}
  	public DataSet queryBySoldierId(String soldierId){
  		
  		return this.executeDataset(PrsSQL.SELECT_PRS_SOLDIERS_PLACEMENT_SOLDIERS_ID, new int[]{Types.VARCHAR},new Object[]{soldierId}, true);
  	}
  	}
