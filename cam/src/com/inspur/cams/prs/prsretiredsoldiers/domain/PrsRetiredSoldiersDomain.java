package com.inspur.cams.prs.prsretiredsoldiers.domain;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.prs.prsawardsmeritorious.dao.IPrsAwardsMeritoriousDao;
import com.inspur.cams.prs.prsawardsmeritorious.dao.PrsAwardsMeritorious;
import com.inspur.cams.prs.prsretiredsoldiers.dao.IPrsRetiredSoldiersDao;
import com.inspur.cams.prs.prsretiredsoldiers.dao.PrsRetiredSoldiers;
import com.inspur.cams.prs.prssoldiersarmy.dao.IPrsSoldiersArmyDao;
import com.inspur.cams.prs.prssoldiersarmy.dao.PrsSoldiersArmy;
import com.inspur.cams.prs.prssoldiersplacement.dao.IPrsSoldiersPlacementDao;
import com.inspur.cams.prs.prssoldiersplacement.dao.PrsSoldiersPlacement;
import com.inspur.cams.prs.prssoldierstrain.dao.IPrsSoldiersTrainDao;
import com.inspur.cams.prs.prssoldierstrain.dao.PrsSoldiersTrain;

public class PrsRetiredSoldiersDomain implements IPrsRetiredSoldiersDomain {

	private IPrsRetiredSoldiersDao prsRetiredSoldiersDao;

	private IPrsSoldiersArmyDao prsSoldiersArmyDao;

	private IPrsSoldiersPlacementDao prsSoldiersPlacementDao;

	private IPrsSoldiersTrainDao prsSoldiersTrainDao;
	
	private IPrsAwardsMeritoriousDao prsAwardsMeritoriousDao;
	
	@Reference
	public void setPrsRetiredSoldiersDao(
			IPrsRetiredSoldiersDao prsRetiredSoldiersDao) {
		this.prsRetiredSoldiersDao = prsRetiredSoldiersDao;
	}

	@Reference
	public void setPrsSoldiersArmyDao(IPrsSoldiersArmyDao prsSoldiersArmyDao) {
		this.prsSoldiersArmyDao = prsSoldiersArmyDao;
	}

	@Reference
	public void setPrsSoldiersPlacementDao(
			IPrsSoldiersPlacementDao prsSoldiersPlacementDao) {
		this.prsSoldiersPlacementDao = prsSoldiersPlacementDao;
	}

	@Reference
	public void setPrsSoldiersTrainDao(IPrsSoldiersTrainDao prsSoldiersTrainDao) {
		this.prsSoldiersTrainDao = prsSoldiersTrainDao;
	}
	
	@Reference
	public void setPrsAwardsMeritoriousDao(
			IPrsAwardsMeritoriousDao prsAwardsMeritoriousDao) {
		this.prsAwardsMeritoriousDao = prsAwardsMeritoriousDao;
	}

	/**
	 * 添加士兵基本信息时，保存士兵部队信息及立功授奖情况到数据库
	 */
	@Trans
	public void saveBaseInfo(PrsRetiredSoldiers soldiers, PrsSoldiersArmy army,List<PrsAwardsMeritorious> awards) {
		
		prsRetiredSoldiersDao.insert(soldiers);
		prsSoldiersArmyDao.insert(army);
		//保存空白安置信息到数据库
		PrsSoldiersPlacement placement = new PrsSoldiersPlacement();
		placement.setPlacementId(IdHelp.getUUID32());
		placement.setSoldierId(soldiers.getSoldiersId());
		prsSoldiersPlacementDao.insert(placement);
		//保存空白
		PrsSoldiersTrain prsTrain = new PrsSoldiersTrain();
		prsTrain.setTrainId(IdHelp.getUUID32());
		prsTrain.setSoldiersId(soldiers.getSoldiersId());
		prsSoldiersTrainDao.insert(prsTrain);
		prsAwardsMeritoriousDao.batchInsert(awards);
	}

	/**
	 * 更新士兵基本信息
	 */
	public void updateSoldier(PrsRetiredSoldiers soldier) {
		prsRetiredSoldiersDao.update(soldier);
	}

	/**
	 * 删除士兵相关信息
	 */
	public void delete(String id) {

		//设置查询条件
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SOLDIERS_ID@=", id);
		
		//删除士兵的安置信息
		int num = prsSoldiersPlacementDao.query(pset).getCount();
		List<String> ids = new ArrayList<String>();
		if (num > 0) {
			for (int i = 0; i < num; i++) {
				PrsSoldiersPlacement plcement = (PrsSoldiersPlacement) prsSoldiersPlacementDao
						.query(pset).getRecord(i).toBean(
								PrsSoldiersPlacement.class);
				ids.add(plcement.getPlacementId());
			}
			prsSoldiersPlacementDao.batchDelete(ids.toArray(new String[ids
					.size()]));
			ids.clear();
		}
		//删除士兵的培训信息
		num = prsSoldiersTrainDao.query(pset).getCount();
		if (num > 0) {
			for (int i = 0; i < num; i++) {
				PrsSoldiersTrain train = (PrsSoldiersTrain) prsSoldiersTrainDao
						.query(pset).getRecord(i)
						.toBean(PrsSoldiersTrain.class);
				ids.add(train.getTrainId());
			}
			prsSoldiersTrainDao
					.batchDelete(ids.toArray(new String[ids.size()]));
			ids.clear();
		}
		//删除士兵的部队信息
		num = prsSoldiersArmyDao.query(pset).getCount();
		if (num > 0) {
			for (int i = 0; i < num; i++) {
				PrsSoldiersArmy army = (PrsSoldiersArmy) prsSoldiersArmyDao
						.query(pset).getRecord(i).toBean(PrsSoldiersArmy.class);
				ids.add(army.getArmyId());
			}
			prsSoldiersArmyDao.batchDelete(ids.toArray(new String[ids.size()]));
			ids.clear();
		}
		//删除士兵的获奖信息
		num = prsAwardsMeritoriousDao.query(pset).getCount();
		if(num>0){
			for(int i=0;i<num;i++){
				PrsAwardsMeritorious award = (PrsAwardsMeritorious) prsAwardsMeritoriousDao.query(pset).getRecord(i).toBean(PrsAwardsMeritorious.class);
				ids.add(award.getAwardsId());
			}
			prsAwardsMeritoriousDao.batchDelete(ids.toArray(new String[ids.size()]));
			ids.clear();
		}
		//删除士兵的基本信息
		prsRetiredSoldiersDao.delete(id);
	}

	public void saveSoldier(PrsRetiredSoldiers soldier) {
		prsRetiredSoldiersDao.insert(soldier);
	}

	/**
	 * 审核通过
	 */
	public void approval(String id) {
		PrsRetiredSoldiers soldier= prsRetiredSoldiersDao.get(id);
		soldier.setFlag("1");
		prsRetiredSoldiersDao.update(soldier);
	}

	/**
	 * 更新退役士兵的部队信息
	 */
	public void updataArmy(PrsSoldiersArmy army) {
		prsSoldiersArmyDao.update(army);
	}
	
	/**
	 * 更新数据库中相关士兵的立功授奖情况
	 */
	public void updataAwards(String id,List<PrsAwardsMeritorious> awards) {
		ParameterSet pset =new ParameterSet();
		pset.setParameter("SOLDIERS_ID@=",id );
		DataSet set= prsAwardsMeritoriousDao.query(pset);
		int count = set.getCount();
		PrsAwardsMeritorious award = null;
		for(int i=0;i<count;i++){
			award = (PrsAwardsMeritorious) set.getRecord(i).toBean(PrsAwardsMeritorious.class);
			prsAwardsMeritoriousDao.delete(award.getAwardsId());
		} 
		prsAwardsMeritoriousDao.batchInsert(awards);
	}

	/**
	 * 上报
	 */
	public void sendUp(String id) {
		PrsRetiredSoldiers soldier = prsRetiredSoldiersDao.get(id);
		soldier.setFlag("2");
		prsRetiredSoldiersDao.update(soldier);
		
	}
	public void updateSoldiers(List<PrsRetiredSoldiers> list) {
		prsRetiredSoldiersDao.batchUpdate(list);
	}

	public DataSet querySoldiers(ParameterSet pset) {
		return prsRetiredSoldiersDao.querySoldiers(pset);
	}
	public DataSet querySoldier(ParameterSet pset) {
		return prsRetiredSoldiersDao.querySoldier(pset);
	}
	public  void updateTrainFlag(String soldierId){
	    prsRetiredSoldiersDao.updateTrainFlag(soldierId);
	}
	
	public void updatePlacementFlag(String soldierId) {
        prsRetiredSoldiersDao.updatePlacementFlag(soldierId);
    }

    public void updateAllotFlag(String[] soldierIds) {
        prsRetiredSoldiersDao.updateAllotFlag(soldierIds);
    }

    public DataSet queryBatchSoldiers(ParameterSet pset) {
        return prsRetiredSoldiersDao.queryBatchSoldiers(pset);
    }

    public DataSet queryDisabilitySoldiers(ParameterSet pset) {
       
        return prsRetiredSoldiersDao.queryDisabilitySoldiers(pset) ;
    }

	public DataSet queryMilitarySoldiers(ParameterSet pset) {
		
		return prsRetiredSoldiersDao.queryMilitarySoldiers(pset);
	}

	public DataSet queryPlacementSoldiers(ParameterSet pset) {
		return prsRetiredSoldiersDao.queryPlacementSoldiers(pset);
	}

	public DataSet queryTrainingSoldiers(ParameterSet pset) {
		return prsRetiredSoldiersDao.queryTrainingSoldiers(pset);
	}

	public DataSet querySoldierss(ParameterSet pset) {
		return prsRetiredSoldiersDao.querySoldierss(pset);
	}

	public DataSet querySoldierById(ParameterSet pset) {
		return prsRetiredSoldiersDao.querySoldierById(pset);
	}

	public DataSet queryPeopleNum(ParameterSet pset) {
		return prsRetiredSoldiersDao.queryBySql(pset);
	}

	public DataSet queryDisabilityPlacement(ParameterSet pset) {
		return prsRetiredSoldiersDao.queryDisabilityPlacement(pset);
	}
	/**
	 * 退役士兵安置地明细表查询
	 * @author linyy
	 * @param pset
	 * @return
	 */
	public DataSet querySoldiersPlacement(ParameterSet pset){
		return prsRetiredSoldiersDao.querySoldiersPlacement(pset);
	}
	/**
	 * 退役士兵培训统计表查询
	 */
	public DataSet querySoldiersTraining(ParameterSet pset){
		return prsRetiredSoldiersDao.querySoldiersTraining(pset);
	}
}
